<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<header class="h-20 lg:h-24 min-h-[80px] lg:min-h-[96px]
               bg-white/90 backdrop-blur-md
               border-b border-slate-200
               flex items-center justify-between
               px-4 sm:px-6 lg:px-10
               sticky top-0 z-30">


    <!-- ===================================================== -->
    <!-- LEFT -->
    <!-- ===================================================== -->

    <div class="flex items-center gap-3 min-w-0">


        <!-- MOBILE MENU BUTTON -->

        <button type="button"
                id="sidebar-open"
                class="lg:hidden
                       h-10 w-10 shrink-0
                       rounded-xl
                       bg-slate-100
                       text-slate-600
                       hover:bg-brand-50
                       hover:text-brand-600
                       flex items-center justify-center
                       transition">

            <svg class="h-5 w-5"
                 fill="none"
                 stroke="currentColor"
                 stroke-width="2"
                 viewBox="0 0 24 24">

                <path stroke-linecap="round"
                      stroke-linejoin="round"
                      d="M4 6h16M4 12h16M4 18h16"/>

            </svg>

        </button>


        <!-- PAGE TITLE -->

        <div class="min-w-0">

            <h1 class="text-lg sm:text-xl lg:text-2xl
                       font-bold text-slate-900
                       tracking-tight truncate">

                <c:out value="${pageTitle}"/>

            </h1>

            <p class="hidden sm:block
                      text-sm text-slate-500 mt-1 truncate">

                <c:out value="${pageSubtitle}"/>

            </p>

        </div>

    </div>


    <!-- ===================================================== -->
    <!-- CURRENT USER -->
    <!-- ===================================================== -->

    <div class="flex items-center gap-3 sm:gap-4 shrink-0">


        <!-- USER INFORMATION -->

        <div class="text-right hidden md:block">

            <p class="text-sm font-bold text-slate-800">

                ${sessionScope.currentUser.first_name}
                ${sessionScope.currentUser.last_name}

            </p>

            <p class="text-xs font-medium text-brand-600 capitalize">

                ${sessionScope.currentUser.role} Account

            </p>

        </div>


        <!-- USER INITIALS -->

        <div class="h-10 w-10 sm:h-12 sm:w-12
                    bg-brand-50
                    text-brand-700
                    rounded-xl sm:rounded-2xl
                    flex items-center justify-center
                    font-bold text-sm sm:text-lg
                    border border-brand-100
                    shadow-sm">

            ${sessionScope.currentUser.first_name.substring(0,1).toUpperCase()}${sessionScope.currentUser.last_name.substring(0,1).toUpperCase()}

        </div>

    </div>

</header>
