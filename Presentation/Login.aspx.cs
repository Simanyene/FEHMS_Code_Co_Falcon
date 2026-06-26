using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_Code_Co_Falcon.Presentation
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        private const int MAX_LOGIN_ATTEMPTS = 5;
        private const int LOCKOUT_MINUTES = 15;
        private const string CONN_STRING = "Server=YOUR_SERVER;Database=YOUR_DATABASE;User Id=YOUR_USER;Password=YOUR_PASSWORD;";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Prevent caching
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
           

            // If already logged in, redirect
            if (Session["CustomerID"] != null)
            {
                Response.Redirect("Default.aspx", false);
                return;
            }

            // Check if account is locked (only on postback check)
            if (IsPostBack)
            {
                string email = txtEmail.Text.Trim();
                if (!string.IsNullOrEmpty(email) && IsAccountLocked(email))
                {
                    pnlLogin.Visible = false;
                    pnlLocked.Visible = true;
                }
            }

            // Check for "Remember Me" cookie on initial load
            if (!IsPostBack)
            {
                HttpCookie emailCookie = Request.Cookies["FEHMS_Email"];
                if (emailCookie != null && !string.IsNullOrEmpty(emailCookie.Value))
                {
                    txtEmail.Text = emailCookie.Value;
                    chkRemember.Checked = true;
                }
            }
        }

        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            // Validate form fields
            if (!Page.IsValid)
            {
                DisplayError("Please correct the errors below.");
                return;
            }

            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            try
            {
                // BRUTE FORCE PROTECTION: Check if account is locked
                if (IsAccountLocked(email))
                {
                    pnlLogin.Visible = false;
                    pnlLocked.Visible = true;
                    LogError($"Login attempt on locked account: {email}");
                    return;
                }

                // Authenticate user against database
                UserCredentials userCreds = AuthenticateUser(email, password);

                if (userCreds != null && userCreds.IsAuthenticated)
                {
                    // Clear failed attempts on successful login
                    ClearFailedAttempts(email);

                    // Set session variables
                    Session["CustomerID"] = userCreds.CustomerID;
                    Session["Email"] = userCreds.Email;
                    Session["FullName"] = userCreds.FullName;
                    Session["UserRole"] = userCreds.UserRole;
                    Session.Timeout = 30; // 30 minute session timeout

                    // Handle "Remember Me" checkbox
                    if (chkRemember.Checked)
                    {
                        // Create persistent cookie (30 days)
                        var cookie = new HttpCookie("FEHMS_Email", email)
                        {
                            Expires = DateTime.Now.AddDays(30),
                            HttpOnly = true,
                            Secure = true, // HTTPS only
                            SameSite = SameSiteMode.Strict
                        };
                        Response.Cookies.Add(cookie);
                    }
                    else
                    {
                        // Clear the remember me cookie if unchecked
                        HttpCookie clearCookie = new HttpCookie("FEHMS_Email")
                        {
                            Expires = DateTime.Now.AddDays(-1)
                        };
                        Response.Cookies.Add(clearCookie);
                    }

                    // Log successful login
                    LogLogin(userCreds.CustomerID, email, true);

                    // Redirect to dashboard or return URL
                    string redirectUrl = Request.QueryString["ReturnUrl"] ?? "Default.aspx";
                    Response.Redirect(redirectUrl, false);
                }
                else
                {
                    // Failed authentication
                    RecordFailedAttempt(email);
                    LogLogin(null, email, false);

                    // Get remaining attempts
                    int remainingAttempts = MAX_LOGIN_ATTEMPTS - GetFailedAttemptCount(email);

                    if (remainingAttempts > 0)
                    {
                        DisplayError($"Invalid email or password. {remainingAttempts} attempt(s) remaining.");
                    }
                    else
                    {
                        DisplayError("Account locked due to too many failed attempts. Please try again in 15 minutes.");
                        pnlLogin.Visible = false;
                        pnlLocked.Visible = true;
                    }
                }
            }
            catch (SqlException sqlEx)
            {
                LogError("SQL Error during login: " + sqlEx.Message);
                DisplayError("A database error occurred. Please try again later.");
            }
            catch (Exception ex)
            {
                LogError("Unexpected error during login: " + ex.Message);
                DisplayError("An unexpected error occurred. Please try again.");
            }
        }

        /// <summary>
        /// Authenticate user credentials against the database
        /// </summary>
        private UserCredentials AuthenticateUser(string email, string password)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(CONN_STRING))
                {
                    conn.Open();

                    // Query to get user by email
                    string query = @"
                        SELECT CustomerID, Email, FullName, PasswordHash, UserRole, IsActive, LastLogin
                        FROM Customers
                        WHERE Email = @Email";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Check if account is active
                                bool isActive = Convert.ToBoolean(reader["IsActive"]);
                                if (!isActive)
                                {
                                    DisplayError("Your account has been deactivated. Please contact support.");
                                    return null;
                                }

                                // Get stored password hash
                                string storedHash = reader["PasswordHash"].ToString();
                                string customerId = reader["CustomerID"].ToString();

                                // Verify password
                                if (VerifyPassword(password, storedHash))
                                {
                                    // Update last login timestamp
                                    UpdateLastLogin(customerId);

                                    // Return user credentials
                                    return new UserCredentials
                                    {
                                        IsAuthenticated = true,
                                        CustomerID = customerId,
                                        Email = reader["Email"].ToString(),
                                        FullName = reader["FullName"].ToString(),
                                        UserRole = reader["UserRole"].ToString()
                                    };
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogError("Error authenticating user: " + ex.Message);
            }

            return null;
        }

        /// <summary>
        /// Hash a password for secure storage
        /// </summary>
        private string HashPassword(string password)
        {
            using (var sha256 = SHA256.Create())
            {
                var hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(hashedBytes);
            }
        }

        /// <summary>
        /// Verify a password against its stored hash
        /// </summary>
        private bool VerifyPassword(string password, string hash)
        {
            var hashOfInput = HashPassword(password);
            return hashOfInput.Equals(hash, StringComparison.OrdinalIgnoreCase);
        }

        /// <summary>
        /// Update the last login timestamp for the user
        /// </summary>
        private void UpdateLastLogin(string customerId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(CONN_STRING))
                {
                    conn.Open();
                    string query = "UPDATE Customers SET LastLogin = @LastLogin WHERE CustomerID = @CustomerID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@CustomerID", customerId);
                        cmd.Parameters.AddWithValue("@LastLogin", DateTime.Now);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                LogError("Error updating last login: " + ex.Message);
            }
        }

        /// <summary>
        /// Record failed login attempt (brute force protection)
        /// </summary>
        private void RecordFailedAttempt(string email)
        {
            string key = $"LOGIN_FAIL_{email}";
            int attempts = Session[key] != null ? (int)Session[key] : 0;
            attempts++;

            Session[key] = attempts;
            Session.Timeout = LOCKOUT_MINUTES; // Keep session alive

            if (attempts >= MAX_LOGIN_ATTEMPTS)
            {
                // Lock account
                string lockKey = $"LOCKED_{email}";
                Session[lockKey] = DateTime.Now;
            }
        }

        /// <summary>
        /// Get the number of failed attempts for an email
        /// </summary>
        private int GetFailedAttemptCount(string email)
        {
            string key = $"LOGIN_FAIL_{email}";
            return Session[key] != null ? (int)Session[key] : 0;
        }

        /// <summary>
        /// Clear failed attempts after successful login
        /// </summary>
        private void ClearFailedAttempts(string email)
        {
            Session[$"LOGIN_FAIL_{email}"] = null;
            Session[$"LOCKED_{email}"] = null;
        }

        /// <summary>
        /// Check if account is temporarily locked due to too many failed attempts
        /// </summary>
        private bool IsAccountLocked(string email)
        {
            string lockKey = $"LOCKED_{email}";

            if (Session[lockKey] != null && Session[lockKey] is DateTime)
            {
                DateTime lockTime = (DateTime)Session[lockKey];
                TimeSpan elapsed = DateTime.Now - lockTime;

                // If lockout period has expired, unlock
                if (elapsed.TotalMinutes > LOCKOUT_MINUTES)
                {
                    ClearFailedAttempts(email);
                    return false;
                }

                return true;
            }

            return false;
        }

        /// <summary>
        /// Display error message to user
        /// </summary>
        private void DisplayError(string message)
        {
            lblError.Text = message;
            lblError.Visible = true;
        }

        /// <summary>
        /// Log login attempts (successful and failed)
        /// </summary>
        private void LogLogin(string customerId, string email, bool success)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(CONN_STRING))
                {
                    conn.Open();
                    string query = @"
                        INSERT INTO LoginLog (CustomerID, Email, LoginTime, IsSuccessful, IPAddress, UserAgent)
                        VALUES (@CustomerID, @Email, @LoginTime, @IsSuccessful, @IPAddress, @UserAgent)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@CustomerID", customerId ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@LoginTime", DateTime.Now);
                        cmd.Parameters.AddWithValue("@IsSuccessful", success);
                        cmd.Parameters.AddWithValue("@IPAddress", Request.UserHostAddress);
                        cmd.Parameters.AddWithValue("@UserAgent", Request.UserAgent ?? "");
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                LogError("Error logging login attempt: " + ex.Message);
            }
        }

        /// <summary>
        /// Log error messages for debugging
        /// </summary>
        private void LogError(string message)
        {
            System.Diagnostics.Debug.WriteLine($"[LOGIN ERROR] {DateTime.Now}: {message}");

            // Optional: Also log to database or file
            try
            {
                string logPath = Server.MapPath("~/Logs/LoginErrors.log");
                System.IO.File.AppendAllText(logPath, $"[{DateTime.Now:yyyy-MM-dd HH:mm:ss}] {message}\n");
            }
            catch { /* Suppress file logging errors */ }
        }
    }

    /// <summary>
    /// User credentials object for returning authentication results
    /// </summary>
    public class UserCredentials
    {
        public bool IsAuthenticated { get; set; }
        public string CustomerID { get; set; }
        public string Email { get; set; }
        public string FullName { get; set; }
        public string UserRole { get; set; }
    }
}
