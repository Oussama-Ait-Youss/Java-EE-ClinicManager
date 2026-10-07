<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Register Patient"/>
<c:set var="pageSubtitle" value="Create a new profile for a clinic patient."/>
<c:set var="activePage" value="patients"/>

<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/includes/head.jsp" %>
<body class="bg-slate-50 font-sans text-slate-800 antialiased flex h-screen overflow-hidden">
<%@ include file="/WEB-INF/views/includes/sidebar.jsp" %>

<main class="flex-1 flex flex-col h-screen overflow-y-auto bg-slate-50/50">
    <%@ include file="/WEB-INF/views/includes/header.jsp" %>

    <div class="p-4 sm:p-6 lg:p-10 max-w-6xl mx-auto w-full">
        <c:if test="${not empty errorMessage}">
            <div role="alert" class="mb-8 flex items-start gap-3 rounded-2xl border border-red-100 bg-red-50 p-4 text-sm text-red-700 shadow-sm">
                <div class="h-8 w-8 rounded-lg bg-red-100 flex items-center justify-center shrink-0">
                    <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v4m0 4h.01M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z"/>
                    </svg>
                </div>
                <div>
                    <p class="font-bold">Error</p>
                    <p class="mt-0.5"><c:out value="${errorMessage}"/></p>
                </div>
            </div>
            <c:remove var="errorMessage" scope="request"/>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/patients/add" method="POST" class="form-card bg-white rounded-3xl border border-slate-200 overflow-hidden">
            <div class="px-6 sm:px-8 py-7 border-b border-slate-100 bg-gradient-to-r from-white to-brand-50/30">
                <div class="flex items-center gap-4">
                    <div class="h-12 w-12 sm:h-14 sm:w-14 rounded-2xl bg-blue-50 text-blue-600 border border-blue-100 flex items-center justify-center shadow-sm">
                        <svg class="h-6 w-6 sm:h-7 sm:w-7" fill="none" stroke="currentColor" stroke-width="1.8" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                        </svg>
                    </div>
                    <div>
                        <h2 class="text-lg sm:text-xl font-bold text-slate-800">Patient Profile</h2>
                        <p class="text-sm text-slate-500 mt-1">Enter the personal contact and portal login information.</p>
                    </div>
                </div>
            </div>

            <div class="p-6 sm:p-8 lg:p-10">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label class="block text-sm font-semibold text-slate-700 mb-2">First Name</label>
                        <input type="text" name="first_name" placeholder="First name" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 focus:ring-2 focus:ring-brand-500 outline-none">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold text-slate-700 mb-2">Last Name</label>
                        <input type="text" name="last_name" placeholder="Last name" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 focus:ring-2 focus:ring-brand-500 outline-none">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold text-slate-700 mb-2">Gender</label>
                        <select name="gender" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 focus:ring-2 focus:ring-brand-500 outline-none">
                            <option value="MALE">Male</option>
                            <option value="FEMALE">Female</option>
                        </select>
                    </div>

                    <div>
                        <label class="block text-sm font-semibold text-slate-700 mb-2">Phone Number</label>
                        <input type="tel" name="phone" placeholder="+212 6 XX XX XX XX" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 focus:ring-2 focus:ring-brand-500 outline-none">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold text-slate-700 mb-2">Email Address</label>
                        <input type="email" name="email" placeholder="patient@example.com" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 focus:ring-2 focus:ring-brand-500 outline-none">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold text-slate-700 mb-2">Patient Portal Password</label>
                        <input type="password" name="password" placeholder="Enter temporary password" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 focus:ring-2 focus:ring-brand-500 outline-none">
                    </div>
                </div>

                <div class="flex flex-col-reverse sm:flex-row items-center justify-between gap-4 mt-10 pt-7 border-t border-slate-100">
                    <a href="${pageContext.request.contextPath}/admin/patients" class="w-full sm:w-auto px-6 py-3 rounded-xl font-semibold text-slate-600 bg-slate-100 hover:bg-slate-200 transition-all text-center">Cancel</a>
                    <button type="submit" class="primary-button w-full sm:w-auto inline-flex items-center justify-center gap-2 px-8 py-3 rounded-xl font-semibold text-white bg-brand-600 hover:bg-brand-700 shadow-lg shadow-brand-600/25">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 5v14M5 12h14"/></svg>
                        Register Patient
                    </button>
                </div>
            </div>
        </form>
    </div>
</main>
</body>
</html>