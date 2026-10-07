<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Edit Patient Profile"/>
<c:set var="pageSubtitle" value="Update patient contact and account details."/>
<c:set var="activePage" value="patients"/>

<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/includes/head.jsp" %>
<body class="bg-slate-50 font-sans text-slate-800 antialiased flex h-screen overflow-hidden">
<%@ include file="/WEB-INF/views/includes/sidebar.jsp" %>

<main class="flex-1 flex flex-col h-screen overflow-y-auto bg-slate-50/50">
    <%@ include file="/WEB-INF/views/includes/header.jsp" %>

    <div class="p-6 md:p-10 max-w-6xl mx-auto w-full">
        <c:if test="${not empty sessionScope.errorMessage}">
            <div role="alert" class="mb-8 flex items-start gap-3 rounded-2xl border border-red-100 bg-red-50 p-4 text-sm text-red-700 shadow-sm">
                <div class="h-8 w-8 rounded-lg bg-red-100 flex items-center justify-center shrink-0">
                    <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 9v4m0 4h.01M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z"/></svg>
                </div>
                <div>
                    <p class="font-bold">Error</p>
                    <p class="mt-0.5"><c:out value="${sessionScope.errorMessage}"/></p>
                </div>
            </div>
            <c:remove var="errorMessage" scope="session"/>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/patients/edit" method="POST" class="bg-white rounded-3xl border border-slate-200 shadow-sm overflow-hidden">
            <input type="hidden" name="id" value="${patient.id}">

            <div class="px-8 py-7 border-b border-slate-100 bg-gradient-to-r from-white to-brand-50/30">
                <div class="flex items-center gap-4">
                    <div class="h-14 w-14 rounded-2xl bg-blue-50 text-blue-600 border border-blue-100 flex items-center justify-center shadow-sm">
                        <svg class="h-7 w-7" fill="none" stroke="currentColor" stroke-width="1.8" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"/></svg>
                    </div>
                    <div>
                        <h2 class="text-xl font-bold text-slate-800">Patient Profile</h2>
                        <p class="text-sm text-slate-500 mt-1">Update the patient's personal and login information.</p>
                    </div>
                </div>
            </div>

            <div class="p-8 md:p-10">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label class="block text-sm font-semibold text-slate-700 mb-2">First Name</label>
                        <input type="text" name="first_name" value="${patient.first_name}" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 hover:bg-white focus:bg-white outline-none">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold text-slate-700 mb-2">Last Name</label>
                        <input type="text" name="last_name" value="${patient.last_name}" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 hover:bg-white focus:bg-white outline-none">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold text-slate-700 mb-2">Gender</label>
                        <select name="gender" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 hover:bg-white focus:bg-white outline-none">
                            <option value="MALE" <c:if test="${patient.gender == 'MALE'}">selected</c:if>>Male</option>
                            <option value="FEMALE" <c:if test="${patient.gender == 'FEMALE'}">selected</c:if>>Female</option>
                        </select>
                    </div>

                    <div>
                        <label class="block text-sm font-semibold text-slate-700 mb-2">Phone Number</label>
                        <input type="tel" name="phone" value="${patient.phone}" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 hover:bg-white focus:bg-white outline-none">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold text-slate-700 mb-2">Email Address</label>
                        <input type="email" name="email" value="${patient.email}" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 hover:bg-white focus:bg-white outline-none">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold text-slate-700 mb-2">Change Password <span class="text-slate-400 font-normal">(optional)</span></label>
                        <input type="password" name="password" placeholder="Leave blank to keep current" class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 hover:bg-white focus:bg-white outline-none">
                        <p class="text-xs text-slate-400 mt-2">Only fill this field if you want to change the password.</p>
                    </div>

                    <div class="col-span-1 md:col-span-2">
                        <label class="block text-sm font-semibold text-slate-700 mb-2">Account Status</label>
                        <select name="active" required class="form-input w-full md:w-1/2 px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 hover:bg-white focus:bg-white outline-none">
                            <option value="true" <c:if test="${patient.active}">selected</c:if>>Active</option>
                            <option value="false" <c:if test="${!patient.active}">selected</c:if>>Inactive</option>
                        </select>
                    </div>
                </div>

                <div class="flex flex-col-reverse sm:flex-row items-center justify-between gap-4 mt-10 pt-7 border-t border-slate-100">
                    <a href="${pageContext.request.contextPath}/admin/patients" class="w-full sm:w-auto px-6 py-3 rounded-xl font-semibold text-slate-600 bg-slate-100 hover:bg-slate-200 transition-all text-center">Cancel</a>
                    <button type="submit" class="w-full sm:w-auto inline-flex items-center justify-center gap-2 px-8 py-3 rounded-xl font-semibold text-white bg-brand-600 hover:bg-brand-700 shadow-lg shadow-brand-600/25 hover:shadow-brand-600/35 transition-all">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/></svg>
                        Save Changes
                    </button>
                </div>
            </div>
        </form>
    </div>
</main>
</body>
</html>