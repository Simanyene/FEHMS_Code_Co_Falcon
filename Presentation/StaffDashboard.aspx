<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/Site1.Master" AutoEventWireup="true" CodeBehind="StaffDashboard.aspx.cs" Inherits="FEHMS_Code_Co_Falcon.Presentation.WebForm5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Code & Co. Falcon — Event Hire Dashboard</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@3.x/dist/tabler-icons.min.css"/>
<style>
    :root {
        --navy:       #0D2137;
        --navy-mid:   #162E47;
        --navy-hover: #1A3554;
        --blue:       #2E9FE6;
        --blue-dim:   #1A6FA3;
        --blue-pale:  #D6EEF9;
        --white:      #FFFFFF;
        --w70:        rgba(255,255,255,0.70);
        --w30:        rgba(255,255,255,0.30);
        --w10:        rgba(255,255,255,0.10);
        --bg:         #F4F6F8;
        --surface:    #FFFFFF;
        --border:     rgba(0,0,0,0.10);
        --text:       #0D2137;
        --text-muted: #5A6A7A;
        --red-bg:     #FCEBEB;
        --red-tx:     #791F1F;
        --grn-bg:     #EAF3DE;
        --grn-tx:     #27500A;
        --amb-bg:     #FAEEDA;
        --amb-tx:     #633806;
    }
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; background: var(--bg); display: flex; height: 100vh; overflow: hidden; color: var(--text); font-size: 14px; }

    .sidebar {
        width: 220px; flex-shrink: 0;
        background: var(--navy);
        display: flex; flex-direction: column;
        height: 100vh;
    }
    .brand {
        padding: 20px 18px 16px;
        border-bottom: 1px solid var(--w10);
    }
    .brand-name { font-size: 14px; font-weight: 600; color: var(--white); letter-spacing: 0.02em; }
    .brand-sub  { font-size: 11px; color: var(--blue); margin-top: 3px; }

    .profile-row {
        display: flex; align-items: center; gap: 10px;
        padding: 14px 18px;
        border-bottom: 1px solid var(--w10);
        cursor: pointer; transition: background 0.15s;
    }
    .profile-row:hover { background: var(--navy-hover); }
    .avatar {
        width: 38px; height: 38px; border-radius: 50%;
        background: var(--blue);
        display: flex; align-items: center; justify-content: center;
        font-size: 13px; font-weight: 600; color: var(--white); flex-shrink: 0;
    }
    .profile-name { font-size: 13px; font-weight: 500; color: var(--white); }
    .profile-role { font-size: 11px; color: var(--w70); margin-top: 1px; }

    nav { flex: 1; padding: 10px 10px 0; }
    .nav-section {
        font-size: 10px; color: var(--w30);
        padding: 10px 8px 4px; letter-spacing: 0.08em;
    }
    .nav-item {
        display: flex; align-items: center; gap: 9px;
        padding: 9px 10px;
        border-radius: 8px;
        cursor: pointer; font-size: 13px;
        color: var(--w70);
        border: none; background: transparent;
        width: 100%; text-align: left;
        transition: background 0.12s, color 0.12s;
        margin-bottom: 2px;
    }
    .nav-item:hover { background: var(--navy-hover); color: var(--white); }
    .nav-item.active { background: var(--blue); color: var(--white); font-weight: 500; }
    .nav-item i { font-size: 18px; flex-shrink: 0; }
    .nav-badge {
        margin-left: auto; font-size: 11px;
        padding: 2px 7px; border-radius: 20px; font-weight: 500;
    }
    .nb-alert { background: #E24B4A; color: #fff; }
    .nb-ok    { background: #3B6D11; color: #C0DD97; }
    .nb-info  { background: var(--w10); color: var(--white); }

    .logout-wrap { padding: 10px; }
    .logout-btn {
        display: flex; align-items: center; gap: 9px;
        padding: 9px 10px; border-radius: 8px;
        cursor: pointer; font-size: 13px; color: #F09595;
        border: none; background: transparent; width: 100%; text-align: left;
        transition: background 0.12s;
    }
    .logout-btn:hover { background: rgba(226,75,74,0.18); }
    .logout-btn i { font-size: 18px; }

    .main { flex: 1; display: flex; flex-direction: column; min-width: 0; }

    .topbar {
        padding: 15px 24px;
        background: var(--surface);
        border-bottom: 1px solid var(--border);
        display: flex; align-items: center; justify-content: space-between;
        flex-shrink: 0;
    }
    .page-title { font-size: 16px; font-weight: 600; color: var(--navy); }
    .topbar-right { display: flex; align-items: center; gap: 8px; }
    .live-dot { width: 8px; height: 8px; border-radius: 50%; background: var(--blue); display: inline-block; }
    .topbar-date { font-size: 12px; color: var(--text-muted); }

    .content {
        flex: 1; padding: 20px 24px;
        overflow-y: auto;
        display: flex; flex-direction: column; gap: 16px;
    }

    .stat-row { display: grid; grid-template-columns: repeat(4,1fr); gap: 12px; }
    .stat-card {
        background: var(--surface);
        border: 1px solid var(--border);
        border-radius: 10px; padding: 14px 16px;
    }
    .stat-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 8px; }
    .stat-label { font-size: 12px; color: var(--text-muted); }
    .stat-icon  { font-size: 18px; color: var(--blue); }
    .stat-value { font-size: 24px; font-weight: 600; color: var(--navy); }
    .stat-value.blue  { color: var(--blue-dim); }
    .stat-value.red   { color: #A32D2D; }
    .stat-value.amber { color: #854F0B; }

    .sec-label {
        font-size: 11px; font-weight: 600; color: var(--text-muted);
        letter-spacing: 0.06em; margin-bottom: 8px;
    }

    .card {
        background: var(--surface);
        border: 1px solid var(--border);
        border-radius: 12px; padding: 14px 16px;
    }

    .brow {
        display: flex; align-items: center; gap: 12px;
        padding: 10px 0;
        border-bottom: 1px solid var(--border);
    }
    .brow:last-child { border-bottom: none; padding-bottom: 0; }
    .brow:first-child { padding-top: 0; }
    .bicon {
        width: 34px; height: 34px; border-radius: 8px;
        background: var(--blue-pale); color: var(--blue-dim);
        display: flex; align-items: center; justify-content: center;
        font-size: 17px; flex-shrink: 0;
    }
    .binfo { flex: 1; min-width: 0; }
    .bname { font-size: 13px; font-weight: 500; color: var(--navy); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
    .bmeta { font-size: 11px; color: var(--text-muted); margin-top: 2px; }

    .badge { font-size: 11px; padding: 3px 9px; border-radius: 20px; font-weight: 500; flex-shrink: 0; white-space: nowrap; }
    .b-ok   { background: var(--grn-bg); color: var(--grn-tx); }
    .b-warn { background: var(--amb-bg); color: var(--amb-tx); }
    .b-blue { background: var(--blue-pale); color: #0C447C; }
    .b-red  { background: var(--red-bg); color: var(--red-tx); }

    .abtn {
        font-size: 12px; padding: 5px 12px;
        border-radius: 7px;
        border: 1px solid var(--border);
        background: transparent; cursor: pointer;
        color: var(--navy); flex-shrink: 0;
        transition: background 0.12s;
    }
    .abtn:hover { background: var(--bg); }
    .abtn.primary {
        background: var(--blue); color: #fff; border-color: var(--blue);
    }
    .abtn.primary:hover { background: var(--blue-dim); border-color: var(--blue-dim); }

    .two-col { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }

    .date-col {
        font-size: 12px; color: var(--text-muted); font-weight: 500;
        min-width: 80px; flex-shrink: 0;
    }

    .spinner { text-align: center; padding: 40px; color: var(--text-muted); }

    @media (max-width: 1200px) {
        .stat-row { grid-template-columns: repeat(2,1fr); }
    }
    @media (max-width: 768px) {
        .sidebar { width: 180px; }
        .stat-row { grid-template-columns: 1fr; }
        .two-col { grid-template-columns: 1fr; }
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <!-- Sidebar -->
    <div class="sidebar">
        <div class="brand">
            <div class="brand-name">Code & Co. Falcon</div>
            <div class="brand-sub">Event Hire System</div>
        </div>

        <!-- Profile Section -->
        <div class="profile-row" onclick="navigateTo('profile', this)">
            <div class="avatar" id="sidebarAvatar">JD</div>
            <div>
                <div class="profile-name" id="sidebarName">John Doe</div>
                <div class="profile-role" id="sidebarRole">Staff</div>
            </div>
        </div>

        <!-- Navigation -->
        <nav>
            <div class="nav-section">MAIN</div>
            <button class="nav-item active" onclick="navigateTo('home', this)">
                <i class="ti ti-home"></i> Home
            </button>
            <button class="nav-item" onclick="navigateTo('schedule', this)">
                <i class="ti ti-calendar"></i> Schedule
            </button>
            
            <div class="nav-section" style="margin-top:16px;">OPERATIONS</div>
            <button class="nav-item" onclick="navigateTo('pickup', this)">
                <i class="ti ti-package-export"></i> Pick up
                <span class="nav-badge nb-info" id="pickupBadge">0</span>
            </button>
            <button class="nav-item" onclick="navigateTo('dropoff', this)">
                <i class="ti ti-package-import"></i> Drop off
                <span class="nav-badge nb-alert" id="dropoffBadge">0</span>
            </button>
        </nav>

        <!-- Logout -->
        <div class="logout-wrap">
            <button class="logout-btn" onclick="logout()">
                <i class="ti ti-logout"></i> Logout
            </button>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main">
        <!-- Top Bar -->
        <div class="topbar">
            <div class="page-title" id="page-title">Home</div>
            <div class="topbar-right">
                <span class="live-dot"></span>
                <span class="topbar-date" id="currentDate"></span>
            </div>
        </div>

        <!-- Content Area -->
        <div class="content" id="content">
            <div class="spinner">Loading...</div>
        </div>
    </div>

    <!-- Hidden data container -->
    <div id="dashboardDataContainer" style="display:none;"></div>


<script>
    // Initialize page data from server
    let allData = {};
    let currentUser = {};

    // Load data on page load
    document.addEventListener('DOMContentLoaded', function () {
        loadDashboardData();
        updateCurrentDate();
        setInterval(updateCurrentDate, 60000); // Update date every minute
    });

    function loadDashboardData() {
        // Fetch all dashboard data via AJAX
        fetch('Dashboard.aspx?action=getPageData', {
            method: 'POST'
        })
            .then(response => response.json())
            .then(data => {
                allData = data.pageData;
                currentUser = data.user;

                // Update sidebar with user info
                document.getElementById('sidebarAvatar').textContent = currentUser.initials || 'JD';
                document.getElementById('sidebarName').textContent = currentUser.name || 'User';
                document.getElementById('sidebarRole').textContent = currentUser.role || 'Staff';
                document.getElementById('pickupBadge').textContent = data.pickupCount || 0;
                document.getElementById('dropoffBadge').textContent = data.dropoffCount || 0;

                // Load home page by default
                navigateTo('home', null);
            })
            .catch(error => {
                console.error('Error loading dashboard:', error);
                document.getElementById('content').innerHTML = '<div class="spinner">Error loading data. Please refresh the page.</div>';
            });
    }

    function navigateTo(page, btn) {
        if (btn) {
            document.querySelectorAll('.nav-item').forEach(el => el.classList.remove('active'));
            btn.classList.add('active');
        }
        renderPage(page);
    }

    function renderPage(page) {
        const data = allData[page];
        if (!data) {
            document.getElementById('content').innerHTML = '<div class="spinner">Page not found</div>';
            return;
        }

        document.getElementById('page-title').textContent = data.title;
        document.getElementById('content').innerHTML = data.html;
    }

    function logout() {
        if (confirm('Are you sure you want to logout?')) {
            window.location.href = 'Login.aspx';
        }
    }

    function updateCurrentDate() {
        const today = new Date();
        const options = { weekday: 'short', year: 'numeric', month: 'short', day: 'numeric' };
        document.getElementById('currentDate').textContent = today.toLocaleDateString('en-US', options);
    }
</script>

</asp:Content>
