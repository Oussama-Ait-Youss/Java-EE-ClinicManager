<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- ========================================================= -->
<!-- MOBILE OVERLAY -->
<!-- ========================================================= -->

<div id="sidebar-overlay"
     class="fixed inset-0 bg-slate-900/50 backdrop-blur-sm z-40 hidden lg:hidden">
</div>


<!-- ========================================================= -->
<!-- SIDEBAR -->
<!-- ========================================================= -->

<aside id="admin-sidebar"
       class="fixed lg:static inset-y-0 left-0 z-50
              w-72 bg-brand-900 text-white
              flex flex-col justify-between
              shadow-2xl
              transform -translate-x-full lg:translate-x-0
              transition-transform duration-300 ease-in-out
              shrink-0">


    <!-- ===================================================== -->
    <!-- TOP -->
    <!-- ===================================================== -->

    <div>


        <!-- ================================================= -->
        <!-- LOGO -->
        <!-- ================================================= -->

        <div class="h-24 flex items-center justify-between px-6 lg:px-8">

            <button type="button"
                    id="sidebar-brand-trigger"
                    class="lg:hidden flex items-center gap-3 text-left w-full text-white transition hover:opacity-90"
                    aria-label="Open navigation menu">

                <span class="flex h-10 w-10 items-center justify-center rounded-xl bg-white text-brand-700 shadow-sm">
                    <svg class="h-6 w-6" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 5v14M5 12h14"/>
                    </svg>
                </span>

                <span class="text-xl font-bold tracking-tight">ClinicManager</span>
            </button>

            <a href="${pageContext.request.contextPath}/admin/dashboard"
               class="hidden lg:flex items-center gap-3">

                <span class="flex h-10 w-10 items-center justify-center rounded-xl bg-white text-brand-700 shadow-sm">
                    <svg class="h-6 w-6" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 5v14M5 12h14"/>
                    </svg>
                </span>

                <span class="text-xl font-bold tracking-tight">ClinicManager</span>
            </a>

            <button type="button"
                    id="sidebar-close"
                    class="hidden lg:hidden h-9 w-9 rounded-lg flex items-center justify-center text-white/70 hover:text-white hover:bg-white/10 transition"
                    aria-label="Close navigation menu">

                <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
                </svg>
            </button>

        </div>


        <!-- ================================================= -->
        <!-- NAVIGATION -->
        <!-- ================================================= -->

        <nav class="px-4 lg:px-5 space-y-2 mt-4">

            <c:set var="activeLink" value="${empty activePage ? '' : activePage}"/>

            <a href="${pageContext.request.contextPath}/admin/dashboard"
               class="sidebar-link flex items-center gap-3 px-4 py-3 rounded-xl font-medium transition ${activeLink == 'dashboard' ? 'bg-white/10 text-white font-semibold' : 'text-white/70 hover:text-white hover:bg-white/5'}">

                <svg class="h-5 w-5 shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6z M14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6z M4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2z M14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"/>
                </svg>

                <span>Dashboard Overview</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/doctors"
               class="sidebar-link flex items-center gap-3 px-4 py-3 rounded-xl font-medium transition ${activeLink == 'doctors' ? 'bg-white/10 text-white font-semibold' : 'text-white/70 hover:text-white hover:bg-white/5'}">

                <svg class="h-5 w-5 shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M5.121 17.804A13.937 13.937 0 0112 16c2.5 0 4.847.655 6.879 1.804 M15 10a3 3 0 11-6 0 3 3 0 016 0 m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                </svg>

                <span>Manage Doctors</span>
            </a>
            <%--    Manage departments        --%>
            <a href="${pageContext.request.contextPath}/admin/departments"
               class="sidebar-link flex items-center gap-3 px-4 py-3 rounded-xl font-medium transition ${activeLink == 'departments' ? 'bg-white/10 text-white font-semibold' : 'text-white/70 hover:text-white hover:bg-white/5'}">
                <svg class="h-5 w-5 shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"/>
                </svg>
                <span>Manage Departments</span>
            </a>
            <%-- Manage Patients --%>
            <a href="${pageContext.request.contextPath}/admin/patients"
               class="sidebar-link flex items-center gap-3 px-4 py-3 rounded-xl font-medium transition ${activeLink == 'patients' ? 'bg-white/10 text-white font-semibold' : 'text-white/70 hover:text-white hover:bg-white/5'}">

                <svg class="h-5 w-5 shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 002-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"/>
                </svg>

                <span>Manage Patients</span>
            </a>
        </nav>

    </div>


    <!-- ===================================================== -->
    <!-- LOGOUT -->
    <!-- ===================================================== -->

    <div class="p-5 lg:p-6 mb-2">

        <a href="${pageContext.request.contextPath}/logout"
           class="flex items-center justify-center gap-2
                  w-full px-4 py-3 rounded-xl
                  font-semibold
                  bg-white/10 text-white/90
                  hover:bg-red-500 hover:text-white
                  transition-all">

            <svg class="w-5 h-5"
                 fill="none"
                 stroke="currentColor"
                 stroke-width="2"
                 viewBox="0 0 24 24">

                <path stroke-linecap="round"
                      stroke-linejoin="round"
                      d="M17 16l4-4m0 0l-4-4m4 4H7
                         m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7
                         a3 3 0 013-3h4a3 3 0 013 3v1"/>

            </svg>

            Sign out

        </a>

        <p class="text-center text-xs text-white/40 mt-5">

            Developed by

            <span class="font-bold text-white/70">
                Ait Youss Oussama
            </span>

        </p>

    </div>

</aside>
