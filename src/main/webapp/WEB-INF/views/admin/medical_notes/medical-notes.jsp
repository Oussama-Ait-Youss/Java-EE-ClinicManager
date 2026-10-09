<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Medical Notes"/>
<c:set var="pageSubtitle" value="Review consultation notes and completed appointments."/>
<c:set var="activePage" value="medical_notes"/>

<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/includes/head.jsp" %>
<body class="bg-slate-50 font-sans text-slate-800 antialiased flex h-screen overflow-hidden">
<%@ include file="/WEB-INF/views/includes/sidebar.jsp" %>

<main class="flex-1 flex flex-col h-screen overflow-y-auto bg-slate-50/50">
    <%@ include file="/WEB-INF/views/includes/header.jsp" %>

    <div class="p-5 sm:p-7 lg:p-10 max-w-7xl mx-auto w-full">
        <c:if test="${not empty sessionScope.successMessage}">
            <div role="alert" class="mb-8 flex items-start gap-3 rounded-2xl border border-brand-100 bg-brand-50 p-4 text-sm text-brand-800 shadow-sm">
                <svg class="mt-0.5 h-5 w-5 shrink-0 text-brand-600" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                </svg>
                <div><p class="font-bold">Success</p><p><c:out value="${sessionScope.successMessage}"/></p></div>
            </div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>

        <c:if test="${not empty sessionScope.errorMessage}">
            <div role="alert" class="mb-8 flex items-start gap-3 rounded-2xl border border-red-100 bg-red-50 p-4 text-sm text-red-700 shadow-sm">
                <svg class="mt-0.5 h-5 w-5 shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v4m0 4h.01M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z"/>
                </svg>
                <div><p class="font-bold">Error</p><p><c:out value="${sessionScope.errorMessage}"/></p></div>
            </div>
            <c:remove var="errorMessage" scope="session"/>
        </c:if>

        <div class="bg-white rounded-2xl sm:rounded-3xl shadow-sm border border-slate-200 overflow-hidden">
            <div class="px-5 sm:px-6 py-5 sm:py-6 border-b border-slate-100 flex flex-col sm:flex-row gap-4 sm:items-center sm:justify-between">
                <div>
                    <h2 class="text-lg font-bold text-slate-800 tracking-tight">Consultation Notes</h2>
                    <p class="text-sm text-slate-500 mt-1">Medical notes are permanently read-only after saving.</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/medical-notes/add"
                   class="bg-brand-600 hover:bg-brand-700 text-white px-5 py-2.5 rounded-xl text-sm font-semibold shadow-lg shadow-brand-600/25 transition-all flex items-center justify-center gap-2 w-full sm:w-auto">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/>
                    </svg>
                    Add Medical Note
                </a>
            </div>

            <div class="overflow-x-auto w-full">
                <table class="w-full text-left border-collapse table-fixed min-w-[800px]">
                    <thead>
                    <tr class="bg-slate-50/80 text-slate-500 text-xs uppercase tracking-wider font-semibold">
                        <th class="px-6 py-4 whitespace-nowrap w-24">Note ID</th>
                        <th class="px-6 py-4 whitespace-nowrap w-1/4">Patient Name</th>
                        <th class="px-6 py-4 whitespace-nowrap w-1/4">Doctor Name</th>
                        <th class="px-6 py-4 whitespace-nowrap w-1/4">Date</th>
                        <th class="px-6 py-4 whitespace-nowrap text-right w-28">Actions</th>
                    </tr>
                    </thead>
                    <tbody class="text-sm divide-y divide-slate-100 bg-white">
                    <c:forEach var="note" items="${medicalNotes}">
                        <tr class="hover:bg-slate-50 transition-colors">
                            <td class="px-6 py-5 whitespace-nowrap font-bold text-slate-700">#<c:out value="${note.id}"/></td>
                            <td class="px-6 py-5 whitespace-nowrap font-semibold text-slate-800">
                                <c:out value="${note.appointment.patient.first_name} ${note.appointment.patient.last_name}"/>
                            </td>
                            <td class="px-6 py-5 whitespace-nowrap text-slate-600">
                                <c:out value="${note.appointment.doctor.title} ${note.appointment.doctor.first_name} ${note.appointment.doctor.last_name}"/>
                            </td>
                            <td class="px-6 py-5 whitespace-nowrap text-slate-500">
                                <c:out value="${note.noteDate}"/>
                            </td>
                            <td class="px-6 py-5 whitespace-nowrap text-right">
                                <a href="${pageContext.request.contextPath}/admin/medical-notes/view?id=${note.id}"
                                   class="inline-flex items-center gap-2 rounded-lg border border-slate-200 px-3 py-2 text-xs font-semibold text-slate-600 hover:border-brand-200 hover:bg-brand-50 hover:text-brand-700 transition-colors"
                                   aria-label="View medical note ${note.id}">
                                    <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 010-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.964-7.178z"/>
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                    </svg>
                                    View
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty medicalNotes}">
                        <tr>
                            <td colspan="5" class="px-6 py-14 text-center">
                                <p class="font-semibold text-slate-700">No medical notes yet</p>
                                <p class="mt-1 text-sm text-slate-500">Add a note after a consultation to see it here.</p>
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>
</body>
</html>
