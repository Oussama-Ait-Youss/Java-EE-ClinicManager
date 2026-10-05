<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Doctors - ClinicManager</title>

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
                    fontFamily: { sans: ['Figtree', 'ui-sans-serif', 'system-ui', 'sans-serif'] },
                    colors: {
                        brand: { 50: '#effaf8', 100: '#d3f3ee', 500: '#14a395', 600: '#0d8579', 700: '#0b6b62', 900: '#0b3b3a' }
                    }
                }
            }
        };
    </script>
</head>
<body class="bg-slate-50 font-sans text-slate-800 antialiased flex h-screen overflow-hidden">

<!-- SIDEBAR -->
<aside class="w-72 bg-brand-900 text-white flex flex-col justify-between relative z-20 shadow-2xl">
    <div class="relative z-10">
        <div class="h-24 flex items-center px-8">
            <div class="flex items-center gap-3">
                    <span class="flex h-10 w-10 items-center justify-center rounded-xl bg-white text-brand-700 shadow-sm">
                        <svg class="h-6 w-6" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 5v14M5 12h14"/></svg>
                    </span>
                <span class="text-xl font-bold tracking-tight">ClinicManager</span>
            </div>
        </div>

        <nav class="px-5 space-y-2 mt-4">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="flex items-center gap-3 px-4 py-3 hover:bg-white/5 rounded-xl font-medium text-white/70 hover:text-white transition-colors">
                <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"/></svg>
                Dashboard Overview
            </a>

            <!-- Active Link: Manage Doctors -->
            <a href="${pageContext.request.contextPath}/admin/doctors" class="flex items-center gap-3 px-4 py-3 bg-white/10 rounded-xl font-semibold text-white transition">
                <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M5.121 17.804A13.937 13.937 0 0112 16c2.5 0 4.847.655 6.879 1.804M15 10a3 3 0 11-6 0 3 3 0 016 0zm6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
                Manage Doctors
            </a>

            <a href="${pageContext.request.contextPath}/admin/staff" class="flex items-center gap-3 px-4 py-3 hover:bg-white/5 rounded-xl font-medium text-white/70 hover:text-white transition-colors">
                <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/></svg>
                Manage Staff
            </a>
            <a href="${pageContext.request.contextPath}/admin/patients" class="flex items-center gap-3 px-4 py-3 hover:bg-white/5 rounded-xl font-medium text-white/70 hover:text-white transition-colors">
                <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 002-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"/></svg>
                Manage Patients
            </a>
        </nav>
    </div>

    <div class="relative z-10 p-6 mb-2">
        <a href="${pageContext.request.contextPath}/logout" class="flex items-center justify-center gap-2 w-full px-4 py-3 bg-white/10 hover:bg-red-500 hover:text-white rounded-xl font-semibold transition-colors text-white/90">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/></svg>
            Sign out
        </a>
    </div>
</aside>

<!-- MAIN CONTENT AREA -->
<main class="flex-1 flex flex-col h-screen overflow-y-auto bg-slate-50/50">

    <!-- TOP HEADER -->
    <header class="h-24 bg-white/80 backdrop-blur-md border-b border-slate-200 flex items-center justify-between px-10 sticky top-0 z-10">
        <div>
            <h1 class="text-2xl font-bold text-slate-900 tracking-tight">Doctors Directory</h1>
            <p class="text-sm text-slate-500 mt-1">View and manage all registered medical professionals.</p>
        </div>

        <div class="flex items-center gap-4">
            <div class="text-right">
                <p class="text-sm font-bold text-slate-800">${sessionScope.currentUser.first_name} ${sessionScope.currentUser.last_name}</p>
                <p class="text-xs font-medium text-brand-600 capitalize">${sessionScope.currentUser.role} Account</p>
            </div>
            <div class="h-12 w-12 bg-brand-50 text-brand-700 rounded-2xl flex items-center justify-center font-bold text-lg border border-brand-100 shadow-sm">
                ${sessionScope.currentUser.first_name.substring(0,1)}${sessionScope.currentUser.last_name.substring(0,1)}
            </div>
        </div>
    </header>

    <!-- PAGE CONTENT -->
    <div class="p-10 max-w-7xl mx-auto w-full">

        <c:if test="${not empty successMessage}">
            <div role="alert" class="mb-8 flex items-start gap-3 rounded-2xl border border-brand-200 bg-brand-50 p-4 text-sm text-brand-800 shadow-sm">
                <svg class="mt-0.5 h-5 w-5 shrink-0 text-brand-600" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
                <div>
                    <p class="font-bold">Success</p>
                    <p><c:out value="${successMessage}"/></p>
                </div>
            </div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>

        <div class="bg-white rounded-3xl shadow-sm border border-slate-200 overflow-hidden">
            <div class="px-8 py-6 border-b border-slate-100 flex justify-between items-center bg-white">
                <div class="relative">
                    <svg class="w-5 h-5 absolute left-3 top-2.5 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/></svg>
                    <input type="text" placeholder="Search doctors..." class="pl-10 pr-4 py-2 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-brand-500 w-64 transition-all">
                </div>

                <!-- Link to Add Doctor Servlet -->
                <a href="${pageContext.request.contextPath}/admin/doctors/add" class="bg-brand-600 hover:bg-brand-700 text-white px-5 py-2.5 rounded-xl text-sm font-semibold shadow-lg shadow-brand-600/25 transition-all flex items-center gap-2">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/></svg>
                    Register New Doctor
                </a>
            </div>

            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead>
                    <tr class="bg-slate-50/80 text-slate-500 text-xs uppercase tracking-wider font-semibold">
                        <th class="px-8 py-4">Matricule</th>
                        <th class="px-8 py-4">Name & Title</th>
                        <th class="px-8 py-4">Department</th>
                        <th class="px-8 py-4">Specialty</th>
                        <th class="px-8 py-4">Status</th>
                        <th class="px-8 py-4 text-right">Actions</th>
                    </tr>
                    </thead>
                    <tbody class="text-sm divide-y divide-slate-100 bg-white">

                    <c:forEach var="doctor" items="${doctors}">
                        <tr class="hover:bg-slate-50 transition-colors group">
                            <td class="px-8 py-5 text-slate-500 font-mono text-xs font-bold">
                                <c:out value="${doctor.matricule}"/>
                            </td>

                            <td class="px-8 py-5">
                                <div class="flex items-center gap-3">
                                    <div class="h-9 w-9 rounded-full bg-brand-50 flex items-center justify-center font-bold text-brand-700 text-xs uppercase border border-brand-100">
                                            ${doctor.first_name.substring(0,1)}${doctor.last_name.substring(0,1)}
                                    </div>
                                    <div>
                                        <span class="font-semibold text-slate-800">${doctor.title} ${doctor.first_name} ${doctor.last_name}</span>
                                        <p class="text-xs text-slate-400 mt-0.5"><c:out value="${doctor.email}"/></p>
                                    </div>
                                </div>
                            </td>

                            <td class="px-8 py-5 text-slate-600 font-medium">
                                <c:out value="${doctor.department.name}"/>
                            </td>

                            <td class="px-8 py-5 text-slate-600 font-medium">
                                <c:out value="${doctor.specialty.name}"/>
                            </td>

                            <td class="px-8 py-5">
                                <c:choose>
                                    <c:when test="${doctor.active}">
                                                <span class="inline-flex items-center px-2.5 py-1 rounded-md text-xs font-bold bg-emerald-50 text-emerald-700 border border-emerald-100">
                                                    <span class="w-1.5 h-1.5 rounded-full bg-emerald-500 mr-1.5"></span>
                                                    Active
                                                </span>
                                    </c:when>
                                    <c:otherwise>
                                                <span class="inline-flex items-center px-2.5 py-1 rounded-md text-xs font-bold bg-slate-100 text-slate-600 border border-slate-200">
                                                    <span class="w-1.5 h-1.5 rounded-full bg-slate-400 mr-1.5"></span>
                                                    Inactive
                                                </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td class="px-8 py-5 text-right">
                                <div class="flex items-center justify-end gap-3 opacity-0 group-hover:opacity-100 transition-opacity">
                                    <!-- Edit Route (e.g., /admin/doctors/edit?id=X) -->
                                    <a href="${pageContext.request.contextPath}/admin/doctors/edit?id=${doctor.id}" class="text-slate-400 hover:text-brand-600 transition" title="Edit">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"/></svg>
                                    </a>
                                    <!-- Delete Form (using POST for safety) -->
                                    <form action="${pageContext.request.contextPath}/admin/doctors/delete" method="POST" class="inline" onsubmit="return confirm('Are you sure you want to disable or delete this doctor?');">
                                        <input type="hidden" name="id" value="${doctor.id}">
                                        <button type="submit" class="text-slate-400 hover:text-red-600 transition" title="Delete">
                                            <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/></svg>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>

                    </tbody>
                </table>
            </div>
        </div>

    </div>
</main>
</body>
</html>