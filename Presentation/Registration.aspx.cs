using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_Code_Co_Falcon.Presentation
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private const string CONN_STRING = "Server=YOUR_SERVER;Database=ForteEventHire;Integrated Security=true;";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                // Clear any previous validation summary display
                valSummary.Visible = false;
            }
        }

        protected void BtnRegister_Click(object sender, EventArgs e)
        {
            // BRUTAL HONESTY: Always validate server-side, never trust client-side alone
            if (!Page.IsValid)
            {
                DisplayValidationSummary();
                return;
            }

            try
            {
                // Get form values and trim whitespace
                string email = txtEmail.Text.Trim();
                string fullName = txtFullName.Text.Trim();
                string phone = txtPhone.Text.Trim();
                string password = txtPassword.Text;

                // BRUTAL HONESTY: Check email uniqueness BEFORE attempting insert
                if (EmailExists(email))
                {
                    DisplayError("This email address is already registered. Please use a different email or try logging in.");
                    return;
                }

                // Hash the password using PBKDF2 (industry standard)
                string hashedPassword = HashPassword(password);

                // Attempt to insert user into database
                if (InsertUserIntoDatabase(email, fullName, phone, hashedPassword))
                {
                    DisplaySuccess("Account created successfully! Redirecting to login...");

                    // Clear form
                    pnlForm.Visible = false;

                    // Redirect after 2 seconds
                    ScriptManager.RegisterStartupScript(this, GetType(), "redirect",
                        "setTimeout(function() { window.location.href = 'Login.aspx'; }, 2000);", true);
                }
                else
                {
                    DisplayError("Failed to create account. Please try again or contact support.");
                    LogError("User insertion returned false for email: " + email);
                }
            }
            catch (SqlException sqlEx)
            {
                // BRUTAL HONESTY: Database errors should be logged, not shown to user
                LogError("SQL Error during registration: " + sqlEx.Message);

                if (sqlEx.Message.Contains("duplicate") || sqlEx.Number == 2601 || sqlEx.Number == 2627)
                {
                    DisplayError("This email is already registered. Please log in or use a different email.");
                }
                else
                {
                    DisplayError("A database error occurred. Please contact support.");
                }
            }
            catch (Exception ex)
            {
                LogError("Unexpected error during registration: " + ex.Message);
                DisplayError("An unexpected error occurred. Please try again.");
            }
        }

        /// <summary>
        /// Check if email already exists in database
        /// BRUTAL HONESTY: Prevent duplicate email registrations
        /// </summary>
        private bool EmailExists(string email)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(CONN_STRING))
                {
                    string query = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        conn.Open();
                        int count = (int)cmd.ExecuteScalar();
                        return count > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError("Error checking email existence: " + ex.Message);
                throw;
            }
        }

        /// <summary>
        /// Insert new user into database with hashed password
        /// BRUTAL HONESTY: Never store plain-text passwords
        /// </summary>
        private bool InsertUserIntoDatabase(string email, string fullName, string phone, string hashedPassword)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(CONN_STRING))
                {
                    string query = @"
                        INSERT INTO Users (Email, FullName, Phone, PasswordHash, RegistrationDate, IsActive, Role)
                        VALUES (@Email, @FullName, @Phone, @PasswordHash, @RegistrationDate, 1, 'Customer')";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        // Use parameterized queries to prevent SQL injection
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@FullName", fullName);
                        cmd.Parameters.AddWithValue("@Phone", string.IsNullOrEmpty(phone) ? (object)DBNull.Value : phone);
                        cmd.Parameters.AddWithValue("@PasswordHash", hashedPassword);
                        cmd.Parameters.AddWithValue("@RegistrationDate", DateTime.Now);

                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        return rowsAffected > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError("Error inserting user: " + ex.Message);
                throw;
            }
        }

        /// <summary>
        /// Hash password using PBKDF2 with salt
        /// BRUTAL HONESTY: Use industry-standard password hashing
        /// </summary>
        private string HashPassword(string password)
        {
            // Use 32-byte salt
            byte[] salt = new byte[32];
            using (var rng = new RNGCryptoServiceProvider())
            {
                rng.GetBytes(salt);
            }

            // Use PBKDF2 with SHA-256
            using (var pbkdf2 = new Rfc2898DeriveBytes(password, salt, 10000, HashAlgorithmName.SHA256))
            {
                byte[] hash = pbkdf2.GetBytes(32);

                // Combine salt + hash
                byte[] hashWithSalt = new byte[salt.Length + hash.Length];
                Array.Copy(salt, 0, hashWithSalt, 0, salt.Length);
                Array.Copy(hash, 0, hashWithSalt, salt.Length, hash.Length);

                // Convert to Base64 for storage
                return Convert.ToBase64String(hashWithSalt);
            }
        }

        /// <summary>
        /// Custom validator for password strength
        /// BRUTAL HONESTY: Enforce strong passwords from day one - technical debt is expensive
        /// </summary>
        protected void ValidatePassword(object source, ServerValidateEventArgs args)
        {
            string password = args.Value;

            // Minimum 8 characters
            if (password.Length < 8)
            {
                args.IsValid = false;
                return;
            }

            // At least one uppercase
            bool hasUpper = false;
            bool hasLower = false;
            bool hasDigit = false;

            foreach (char c in password)
            {
                if (char.IsUpper(c)) hasUpper = true;
                if (char.IsLower(c)) hasLower = true;
                if (char.IsDigit(c)) hasDigit = true;
            }

            args.IsValid = (hasUpper && hasLower && hasDigit);
        }

        /// <summary>
        /// Display success message to user
        /// </summary>
        private void DisplaySuccess(string message)
        {
            lblSuccess.Text = message;
            lblSuccess.Visible = true;
            lblError.Visible = false;
        }

        /// <summary>
        /// Display error message to user
        /// </summary>
        private void DisplayError(string message)
        {
            lblError.Text = message;
            lblError.Visible = true;
            lblSuccess.Visible = false;
        }

        /// <summary>
        /// Display validation summary if there are errors
        /// </summary>
        private void DisplayValidationSummary()
        {
            valSummary.Visible = true;
            lblError.Visible = false;
            lblSuccess.Visible = false;
        }

        /// <summary>
        /// Validate that user has agreed to terms
        /// BRUTAL HONESTY: CheckBox validation requires direct checking, not ControlToValidate
        /// </summary>
        protected void ValidateTerms(object source, ServerValidateEventArgs args)
        {
            // Check the checkbox directly - don't rely on ControlToValidate
            args.IsValid = chkTerms.Checked;
        }

        /// <summary>
        /// Log errors for debugging and auditing
        /// BRUTAL HONESTY: Always log errors to file or database for debugging
        /// </summary>
        private void LogError(string message)
        {
            try
            {
                string logMessage = $"[REGISTRATION ERROR] {DateTime.Now:yyyy-MM-dd HH:mm:ss}: {message}";

                // Log to Debug output (visible in Visual Studio)
                System.Diagnostics.Debug.WriteLine(logMessage);

                // TODO: Implement file logging or database logging in production
                // Example: Log to application log file
                // string logPath = Server.MapPath("~/App_Data/Logs/Registration_" + DateTime.Now.ToString("yyyy-MM-dd") + ".txt");
                // System.IO.File.AppendAllText(logPath, logMessage + Environment.NewLine);
            }
            catch
            {
                // Silently fail if logging fails
            }
        }
    }
}
