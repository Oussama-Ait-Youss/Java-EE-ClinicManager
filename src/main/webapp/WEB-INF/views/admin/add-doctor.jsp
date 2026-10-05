<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Add Doctor - ClinicManager</title>

    <!-- Figtree Font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        sans: ['Figtree', 'ui-sans-serif', 'system-ui', 'sans-serif']
                    },
                    colors: {
                        brand: {
                            50: '#effaf8',
                            100: '#d3f3ee',
                            500: '#14a395',
                            600: '#0d8579',
                            700: '#0b6b62',
                            900: '#0b3b3a'
                        }
                    }
                }
            }
        };
    </script>

</head>

<body class="bg-slate-50 font-sans text-slate-800 antialiased flex h-screen overflow-hidden">

<!-- ========================================================= -->

<!-- SIDEBAR -->

<!-- ========================================================= -->

<aside class="w-72 bg-brand-900 text-white flex flex-col justify-between relative z-20 shadow-2xl">

    <div class="relative z-10">

        <!-- LOGO -->
        <div class="h-24 flex items-center px-8">

            <div class="flex items-center gap-3">

            <span class="flex h-10 w-10 items-center justify-center rounded-xl bg-white text-brand-700 shadow-sm">

                <svg class="h-6 w-6"
                     fill="none"
                     stroke="currentColor"
                     stroke-width="2.5"
                     viewBox="0 0 24 24">

                    <path stroke-linecap="round"
                          stroke-linejoin="round"
                          d="M12 5v14M5 12h14"/>

                </svg>

            </span>

                <span class="text-xl font-bold tracking-tight">
                ClinicManager
            </span>

            </div>

        </div>


        <!-- NAVIGATION -->

        <nav class="px-5 space-y-2 mt-4">

            <!-- Dashboard -->

            <a href="${pageContext.request.contextPath}/admin/dashboard"
               class="flex items-center gap-3 px-4 py-3 hover:bg-white/5 rounded-xl font-medium text-white/70 hover:text-white transition-colors">

                <svg class="h-5 w-5"
                     fill="none"
                     stroke="currentColor"
                     stroke-width="2"
                     viewBox="0 0 24 24">

                    <path stroke-linecap="round"
                          stroke-linejoin="round"
                          d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6z
                         M14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6z
                         M4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2z
                         M14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"/>

                </svg>

                Dashboard Overview

            </a>


            <!-- Doctors ACTIVE -->

            <a href="${pageContext.request.contextPath}/admin/doctors"
               class="flex items-center gap-3 px-4 py-3 bg-white/10 rounded-xl font-semibold text-white transition">

                <svg class="h-5 w-5"
                     fill="none"
                     stroke="currentColor"
                     stroke-width="2"
                     viewBox="0 0 24 24">

                    <path stroke-linecap="round"
                          stroke-linejoin="round"
                          d="M5.121 17.804A13.937 13.937 0 0112 16c2.5 0 4.847.655 6.879 1.804
                         M15 10a3 3 0 11-6 0 3 3 0 016 0
                         m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>

                </svg>

                Manage Doctors

            </a>


            <!-- Staff -->

            <a href="${pageContext.request.contextPath}/admin/staff"
               class="flex items-center gap-3 px-4 py-3 hover:bg-white/5 rounded-xl font-medium text-white/70 hover:text-white transition-colors">

                <svg class="h-5 w-5"
                     fill="none"
                     stroke="currentColor"
                     stroke-width="2"
                     viewBox="0 0 24 24">

                    <path stroke-linecap="round"
                          stroke-linejoin="round"
                          d="M17 20h5v-2a3 3 0 00-5.356-1.857
                         M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857
                         M7 20H2v-2a3 3 0 015.356-1.857
                         M7 20v-2c0-.656.126-1.283.356-1.857
                         m0 0a5.002 5.002 0 019.288 0
                         M15 7a3 3 0 11-6 0 3 3 0 016 0
                         m6 3a2 2 0 11-4 0 2 2 0 014 0
                         M7 10a2 2 0 11-4 0 2 2 0 014 0z"/>

                </svg>

                Manage Staff

            </a>


            <!-- Patients -->

            <a href="${pageContext.request.contextPath}/admin/patients"
               class="flex items-center gap-3 px-4 py-3 hover:bg-white/5 rounded-xl font-medium text-white/70 hover:text-white transition-colors">

                <svg class="h-5 w-5"
                     fill="none"
                     stroke="currentColor"
                     stroke-width="2"
                     viewBox="0 0 24 24">

                    <path stroke-linecap="round"
                          stroke-linejoin="round"
                          d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2
                         m14 0V9a2 2 0 00-2-2
                         M5 11V9a2 2 0 002-2
                         m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2
                         M7 7h10"/>

                </svg>

                Manage Patients

            </a>


            <!-- Settings -->

            <a href="${pageContext.request.contextPath}/admin/settings"
               class="flex items-center gap-3 px-4 py-3 hover:bg-white/5 rounded-xl font-medium text-white/70 hover:text-white transition-colors">

                <svg class="h-5 w-5"
                     fill="none"
                     stroke="currentColor"
                     stroke-width="2"
                     viewBox="0 0 24 24">

                    <path stroke-linecap="round"
                          stroke-linejoin="round"
                          d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0
                         a1.724 1.724 0 002.573 1.066
                         c1.543-.94 3.31.826 2.37 2.37
                         a1.724 1.724 0 001.065 2.572
                         c1.756.426 1.756 2.924 0 3.35
                         a1.724 1.724 0 00-1.066 2.573
                         c.94 1.543-.826 3.31-2.37 2.37
                         a1.724 1.724 0 00-2.572 1.065
                         c-.426 1.756-2.924 1.756-3.35 0
                         a1.724 1.724 0 00-2.573-1.066
                         c-1.543.94-3.31-.826-2.37-2.37
                         a1.724 1.724 0 00-1.065-2.572
                         c-1.756-.426-1.756-2.924 0-3.35
                         a1.724 1.724 0 001.066-2.573
                         c-.94-1.543.826-3.31 2.37-2.37
                         .996.608 2.296.07 2.572-1.065z"/>

                    <path stroke-linecap="round"
                          stroke-linejoin="round"
                          d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>

                </svg>

                System Settings

            </a>

        </nav>

    </div>


    <!-- LOGOUT -->

    <div class="relative z-10 p-6 mb-2">

        <a href="${pageContext.request.contextPath}/logout"
           class="flex items-center justify-center gap-2 w-full px-4 py-3 bg-white/10 hover:bg-red-500 hover:text-white rounded-xl font-semibold transition-colors text-white/90">

            <svg class="w-5 h-5"
                 fill="none"
                 stroke="currentColor"
                 stroke-width="2"
                 viewBox="0 0 24 24">

                <path stroke-linecap="round"
                      stroke-linejoin="round"
                      d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>

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

<!-- ========================================================= -->

<!-- MAIN -->

<!-- ========================================================= -->

<main class="flex-1 flex flex-col h-screen overflow-y-auto bg-slate-50/50">


    <!-- HEADER -->

    <header class="h-24 bg-white/80 backdrop-blur-md border-b border-slate-200 flex items-center justify-between px-10 sticky top-0 z-10">

        <div>

            <h1 class="text-2xl font-bold text-slate-900 tracking-tight">
                Register Medical Staff
            </h1>

            <p class="text-sm text-slate-500 mt-1">
                Create a new doctor account and assign their specialty.
            </p>

        </div>


        <!-- CURRENT USER -->

        <div class="flex items-center gap-4">

            <div class="text-right">

                <p class="text-sm font-bold text-slate-800">
                    ${sessionScope.currentUser.first_name}
                    ${sessionScope.currentUser.last_name}
                </p>

                <p class="text-xs font-medium text-brand-600 capitalize">
                    ${sessionScope.currentUser.role} Account
                </p>

            </div>


            <div class="h-12 w-12 bg-brand-50 text-brand-700 rounded-2xl flex items-center justify-center font-bold text-lg border border-brand-100 shadow-sm">

                ${sessionScope.currentUser.first_name.substring(0,1).toUpperCase()}${sessionScope.currentUser.last_name.substring(0,1).toUpperCase()}

            </div>

        </div>

    </header>


    <!-- ===================================================== -->
    <!-- PAGE CONTENT -->
    <!-- ===================================================== -->

    <div class="p-10 max-w-7xl mx-auto w-full">


        <!-- ERROR MESSAGE -->

        <c:if test="${not empty errorMessage}">

            <div role="alert"
                 class="mb-8 flex items-start gap-3 rounded-2xl border border-red-100 bg-red-50 p-4 text-sm text-red-700 shadow-sm">

                <svg class="mt-0.5 h-5 w-5 shrink-0"
                     fill="none"
                     stroke="currentColor"
                     stroke-width="2"
                     viewBox="0 0 24 24">

                    <path stroke-linecap="round"
                          stroke-linejoin="round"
                          d="M12 9v4m0 4h.01
                         M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z"/>

                </svg>

                <div>

                    <p class="font-bold">
                        Error
                    </p>

                    <p>
                        <c:out value="${errorMessage}"/>
                    </p>

                </div>

            </div>

        </c:if>


        <!-- FORM -->

        <form action="${pageContext.request.contextPath}/admin/doctors/add"
              method="POST"
              class="bg-white rounded-3xl shadow-sm border border-slate-200 overflow-hidden">


            <!-- FORM HEADER -->

            <div class="px-8 py-7 border-b border-slate-100">

                <div class="flex items-center gap-4">

                    <div class="h-12 w-12 rounded-2xl bg-brand-50 text-brand-600 flex items-center justify-center">

                        <svg class="h-6 w-6"
                             fill="none"
                             stroke="currentColor"
                             stroke-width="2"
                             viewBox="0 0 24 24">

                            <path stroke-linecap="round"
                                  stroke-linejoin="round"
                                  d="M15 11a3 3 0 10-6 0
                                 3 3 0 006 0z
                                 M19 20a7 7 0 00-14 0
                                 M19 20h2
                                 M5 20H3"/>

                        </svg>

                    </div>

                    <div>

                        <h2 class="text-lg font-bold text-slate-800">
                            Medical Profile
                        </h2>

                        <p class="text-sm text-slate-500 mt-1">
                            Enter the professional information of the doctor.
                        </p>

                    </div>

                </div>

            </div>


            <!-- FORM BODY -->

            <div class="p-8">


                <!-- PROFESSIONAL INFORMATION -->

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">


                    <!-- Matricule -->

                    <div>

                        <label class="block text-sm font-semibold text-slate-700 mb-2">
                            Matricule
                        </label>

                        <input type="text"
                               name="matricule"
                               placeholder="e.g. DOC-002"
                               required
                               class="w-full px-4 py-3 rounded-xl border border-slate-200 bg-white
                                  focus:ring-2 focus:ring-brand-500 focus:border-brand-500
                                  outline-none transition">

                    </div>


                    <!-- Title -->

                    <div>

                        <label class="block text-sm font-semibold text-slate-700 mb-2">
                            Title
                        </label>

                        <select name="title"
                                required
                                class="w-full px-4 py-3 rounded-xl border border-slate-200 bg-white
                                   focus:ring-2 focus:ring-brand-500 focus:border-brand-500
                                   outline-none transition">

                            <option value="Dr.">Dr.</option>
                            <option value="Pr.">Pr.</option>

                        </select>

                    </div>


                    <!-- Department -->

                    <div>

                        <label class="block text-sm font-semibold text-slate-700 mb-2">
                            Department
                        </label>

                        <select name="department_id"
                                required
                                class="w-full px-4 py-3 rounded-xl border border-slate-200 bg-white
                                   focus:ring-2 focus:ring-brand-500 focus:border-brand-500
                                   outline-none transition">

                            <option value="" disabled selected>
                                Select Department
                            </option>

                            <c:forEach var="dept" items="${departments}">

                                <option value="${dept.id}">
                                        ${dept.name}
                                </option>

                            </c:forEach>

                        </select>

                    </div>


                    <!-- Specialty -->

                    <div>

                        <label class="block text-sm font-semibold text-slate-700 mb-2">
                            Specialty
                        </label>

                        <select name="specialty_id"
                                required
                                class="w-full px-4 py-3 rounded-xl border border-slate-200 bg-white
                                   focus:ring-2 focus:ring-brand-500 focus:border-brand-500
                                   outline-none transition">

                            <option value="" disabled selected>
                                Select Specialty
                            </option>

                            <c:forEach var="spec" items="${specialties}">

                                <option value="${spec.id}">
                                        ${spec.name}
                                </option>

                            </c:forEach>

                        </select>

                    </div>

                </div>


                <!-- SEPARATOR -->

                <div class="my-10 border-t border-slate-100"></div>


                <!-- PERSONAL INFORMATION -->

                <div class="mb-6">

                    <h2 class="text-lg font-bold text-slate-800">
                        Personal & Account Information
                    </h2>

                    <p class="text-sm text-slate-500 mt-1">
                        Enter the doctor's personal and login information.
                    </p>

                </div>


                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">


                    <!-- First Name -->

                    <div>

                        <label class="block text-sm font-semibold text-slate-700 mb-2">
                            First Name
                        </label>

                        <input type="text"
                               name="first_name"
                               required
                               class="w-full px-4 py-3 rounded-xl border border-slate-200 bg-white
                                  focus:ring-2 focus:ring-brand-500 focus:border-brand-500
                                  outline-none transition">

                    </div>


                    <!-- Last Name -->

                    <div>

                        <label class="block text-sm font-semibold text-slate-700 mb-2">
                            Last Name
                        </label>

                        <input type="text"
                               name="last_name"
                               required
                               class="w-full px-4 py-3 rounded-xl border border-slate-200 bg-white
                                  focus:ring-2 focus:ring-brand-500 focus:border-brand-500
                                  outline-none transition">

                    </div>


                    <!-- Gender -->

                    <div>

                        <label class="block text-sm font-semibold text-slate-700 mb-2">
                            Gender
                        </label>

                        <select name="gender"
                                required
                                class="w-full px-4 py-3 rounded-xl border border-slate-200 bg-white
                                   focus:ring-2 focus:ring-brand-500 focus:border-brand-500
                                   outline-none transition">

                            <option value="MALE">
                                Male
                            </option>

                            <option value="FEMALE">
                                Female
                            </option>

                        </select>

                    </div>


                    <!-- Phone -->

                    <div>

                        <label class="block text-sm font-semibold text-slate-700 mb-2">
                            Phone Number
                        </label>

                        <input type="tel"
                               name="phone"
                               placeholder="+212 6XX XX XX XX"
                               required
                               class="w-full px-4 py-3 rounded-xl border border-slate-200 bg-white
                                  focus:ring-2 focus:ring-brand-500 focus:border-brand-500
                                  outline-none transition">

                    </div>


                    <!-- Email -->

                    <div>

                        <label class="block text-sm font-semibold text-slate-700 mb-2">
                            Email Address
                        </label>

                        <input type="email"
                               name="email"
                               placeholder="doctor@example.com"
                               required
                               class="w-full px-4 py-3 rounded-xl border border-slate-200 bg-white
                                  focus:ring-2 focus:ring-brand-500 focus:border-brand-500
                                  outline-none transition">

                    </div>


                    <!-- Password -->

                    <div>

                        <label class="block text-sm font-semibold text-slate-700 mb-2">
                            Temporary Password
                        </label>

                        <input type="password"
                               name="password"
                               required
                               class="w-full px-4 py-3 rounded-xl border border-slate-200 bg-white
                                  focus:ring-2 focus:ring-brand-500 focus:border-brand-500
                                  outline-none transition">

                    </div>

                </div>


                <!-- ACTIONS -->

                <div class="flex items-center justify-end gap-4 mt-10 pt-6 border-t border-slate-100">

                    <a href="${pageContext.request.contextPath}/admin/doctors"
                       class="px-6 py-3 rounded-xl font-semibold text-slate-600 bg-slate-100
                          hover:bg-slate-200 transition">

                        Cancel

                    </a>

                    <button type="submit"
                            class="px-8 py-3 rounded-xl font-semibold text-white
                               bg-brand-600 hover:bg-brand-700
                               shadow-lg shadow-brand-600/25
                               transition">

                        Register Doctor

                    </button>

                </div>

            </div>

        </form>

    </div>

</main>

</body>
</html>
