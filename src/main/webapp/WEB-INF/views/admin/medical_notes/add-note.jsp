<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Add Medical Note"/>
<c:set var="pageSubtitle" value="Document the consultation and complete its appointment."/>
<c:set var="activePage" value="medical_notes"/>

<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/includes/head.jsp" %>
<body class="bg-slate-50 font-sans text-slate-800 antialiased flex h-screen overflow-hidden">
<%@ include file="/WEB-INF/views/includes/sidebar.jsp" %>

<main class="flex-1 flex flex-col h-screen overflow-y-auto bg-slate-50/50">
    <%@ include file="/WEB-INF/views/includes/header.jsp" %>

    <div class="p-5 sm:p-7 lg:p-10 max-w-4xl mx-auto w-full">
        <c:if test="${not empty errorMessage}">
            <div role="alert" class="mb-6 flex items-start gap-3 rounded-2xl border border-red-100 bg-red-50 p-4 text-sm text-red-700 shadow-sm">
                <svg class="mt-0.5 h-5 w-5 shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v4m0 4h.01M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z"/>
                </svg>
                <div><p class="font-bold">Unable to save note</p><p><c:out value="${errorMessage}"/></p></div>
            </div>
        </c:if>

        <div class="bg-white rounded-3xl shadow-sm border border-slate-200 overflow-hidden">
            <div class="border-b border-slate-100 px-6 py-6 sm:px-8">
                <div class="flex items-start gap-4">
                    <div class="flex h-12 w-12 shrink-0 items-center justify-center rounded-2xl bg-brand-50 text-brand-600">
                        <svg class="h-6 w-6" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                        </svg>
                    </div>
                    <div>
                        <h2 class="text-lg font-bold tracking-tight text-slate-800">New consultation note</h2>
                        <p class="mt-1 text-sm text-slate-500">Saving this note will mark its appointment as completed.</p>
                    </div>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/admin/medical-notes/add" method="post" class="space-y-6 px-6 py-7 sm:px-8">
                <div>
                    <label for="appointmentId" class="mb-2 block text-sm font-semibold text-slate-700">Scheduled appointment</label>
                    <select id="appointmentId" name="appointmentId" required
                            class="w-full rounded-xl border border-slate-200 bg-white px-4 py-3 text-sm text-slate-700 focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20">
                        <option value="">Select an appointment</option>
                        <c:forEach var="appt" items="${scheduledAppointments}">
                            <option value="${appt.id}" ${selectedAppointmentId == appt.id ? 'selected' : ''}>
                                #<c:out value="${appt.id}"/> · <c:out value="${appt.appointmentDate}"/> at <c:out value="${appt.appointmentTime}"/> ·
                                <c:out value="${appt.patient.first_name} ${appt.patient.last_name}"/> with
                                <c:out value="${appt.doctor.title} ${appt.doctor.first_name} ${appt.doctor.last_name}"/>
                            </option>
                        </c:forEach>
                    </select>
                    <c:if test="${empty scheduledAppointments}">
                        <p class="mt-2 text-sm text-amber-700">There are no scheduled appointments available for a new note.</p>
                    </c:if>
                </div>

                <div>
                    <label for="diagnostic" class="mb-2 block text-sm font-semibold text-slate-700">Diagnostic</label>
                    <input type="text" id="diagnostic" name="diagnostic" required maxlength="255"
                           value="<c:out value='${diagnostic}'/>"
                           placeholder="Enter the consultation diagnostic"
                           class="w-full rounded-xl border border-slate-200 px-4 py-3 text-sm text-slate-700 placeholder:text-slate-400 focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20">
                </div>

                <div>
                    <label for="content" class="mb-2 block text-sm font-semibold text-slate-700">Medical note</label>
                    <textarea id="content" name="content" rows="6" required
                              placeholder="Document symptoms, examination findings, treatment, and follow-up recommendations..."
                              class="w-full resize-y rounded-xl border border-slate-200 px-4 py-3 text-sm leading-6 text-slate-700 placeholder:text-slate-400 focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20"><c:out value="${content}"/></textarea>
                </div>

                <div class="flex flex-col-reverse gap-3 border-t border-slate-100 pt-6 sm:flex-row sm:justify-end">
                    <a href="${pageContext.request.contextPath}/admin/medical-notes"
                       class="inline-flex items-center justify-center rounded-xl border border-slate-200 px-5 py-3 text-sm font-semibold text-slate-600 hover:bg-slate-50 transition-colors">
                        Cancel
                    </a>
                    <button type="submit" ${empty scheduledAppointments ? 'disabled' : ''}
                            class="inline-flex items-center justify-center gap-2 rounded-xl bg-brand-600 px-5 py-3 text-sm font-semibold text-white shadow-lg shadow-brand-600/25 transition-all hover:bg-brand-700 disabled:cursor-not-allowed disabled:opacity-50">
                        <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/>
                        </svg>
                        Save Medical Note
                    </button>
                </div>
            </form>
        </div>
    </div>
</main>
</body>
</html>
