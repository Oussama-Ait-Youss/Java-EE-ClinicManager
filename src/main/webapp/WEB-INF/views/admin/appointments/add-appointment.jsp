<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Schedule Appointment"/>
<c:set var="pageSubtitle" value="Book a new clinic visit for a patient."/>
<c:set var="activePage" value="appointments"/>

<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/includes/head.jsp" %>
<body class="bg-slate-50 font-sans text-slate-800 antialiased flex h-screen overflow-hidden">
<%@ include file="/WEB-INF/views/includes/sidebar.jsp" %>

<main class="flex-1 flex flex-col h-screen overflow-y-auto bg-slate-50/50">
    <%@ include file="/WEB-INF/views/includes/header.jsp" %>

    <div class="p-4 sm:p-6 lg:p-10 max-w-4xl mx-auto w-full">
        <c:if test="${not empty errorMessage}">
            <div role="alert" class="mb-8 flex items-start gap-3 rounded-2xl border border-red-100 bg-red-50 p-4 text-sm text-red-700 shadow-sm">
                <div class="h-8 w-8 rounded-lg bg-red-100 flex items-center justify-center shrink-0">
                    <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 9v4m0 4h.01M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z"/></svg>
                </div>
                <div>
                    <p class="font-bold">Error</p>
                    <p class="mt-0.5"><c:out value="${errorMessage}"/></p>
                </div>
            </div>
            <c:remove var="errorMessage" scope="request"/>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/appointments/add" method="POST" class="form-card bg-white rounded-3xl border border-slate-200 overflow-hidden">
            <div class="px-6 sm:px-8 py-7 border-b border-slate-100 bg-gradient-to-r from-white to-brand-50/30">
                <div class="flex items-center gap-4">
                    <div class="h-12 w-12 sm:h-14 sm:w-14 rounded-2xl bg-brand-50 text-brand-600 border border-brand-100 flex items-center justify-center shadow-sm">
                        <svg class="h-6 w-6 sm:h-7 sm:w-7" fill="none" stroke="currentColor" stroke-width="1.8" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M8 7V3m8 4V3M4 11h16M5 21h14a1 1 0 001-1V7a1 1 0 00-1-1H5a1 1 0 00-1 1v13a1 1 0 001 1z"/>
                        </svg>
                    </div>
                    <div>
                        <h2 class="text-lg sm:text-xl font-bold text-slate-800">Appointment Details</h2>
                        <p class="text-sm text-slate-500 mt-1">Select the patient, doctor, and timeslot.</p>
                    </div>
                </div>
            </div>

            <div class="p-6 sm:p-8">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label class="block text-sm font-semibold text-slate-700 mb-2">Select Patient</label>
                        <select name="patient_id" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 focus:ring-2 focus:ring-brand-500 outline-none">
                            <option value="" disabled selected>Choose a patient...</option>
                            <c:forEach var="patient" items="${patients}">
                                <option value="${patient.id}">${patient.first_name} ${patient.last_name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div>
                        <label class="block text-sm font-semibold text-slate-700 mb-2">Select Doctor</label>
                        <select name="doctor_id" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 focus:ring-2 focus:ring-brand-500 outline-none">
                            <option value="" disabled selected>Choose a doctor...</option>
                            <c:forEach var="doctor" items="${doctors}">
                                <option value="${doctor.id}">${doctor.title} ${doctor.first_name} ${doctor.last_name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div>
                        <label class="block text-sm font-semibold text-slate-700 mb-2">Date</label>
                        <input type="date" name="appointment_date" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 focus:ring-2 focus:ring-brand-500 outline-none">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold text-slate-700 mb-2">Time</label>
                        <input type="time" name="appointment_time" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 focus:ring-2 focus:ring-brand-500 outline-none">
                    </div>

                    <!-- ADDED APPOINTMENT TYPE -->
                    <div>
                        <label class="block text-sm font-semibold text-slate-700 mb-2">Appointment Type</label>
                        <select name="type" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 focus:ring-2 focus:ring-brand-500 outline-none">
                            <option value="" disabled selected>Select Type...</option>
                            <option value="CONSULTATION">Consultation</option>
                            <option value="CHECKUP">Checkup</option>
                            <option value="TREATMENT">Treatment</option>
                            <option value="SURGERY">Surgery</option>
                        </select>
                    </div>

                    <div>
                        <label class="block text-sm font-semibold text-slate-700 mb-2">Status</label>
                        <select name="status" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 focus:ring-2 focus:ring-brand-500 outline-none">
                            <option value="SCHEDULED">Scheduled</option>
                            <option value="COMPLETED">Completed</option>
                            <option value="CANCELLED">Cancelled</option>
                        </select>
                    </div>

                    <div class="md:col-span-2">
                        <label class="block text-sm font-semibold text-slate-700 mb-2">Notes <span class="text-slate-400 font-normal">(Optional)</span></label>
                        <textarea name="notes" rows="3" placeholder="Reason for visit or additional notes..." class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 focus:ring-2 focus:ring-brand-500 outline-none resize-none"></textarea>
                    </div>
                </div>

                <div class="flex flex-col-reverse sm:flex-row items-center justify-end gap-4 mt-10 pt-7 border-t border-slate-100">
                    <a href="${pageContext.request.contextPath}/admin/appointments" class="w-full sm:w-auto px-6 py-3 rounded-xl font-semibold text-slate-600 bg-slate-100 hover:bg-slate-200 transition-all text-center">Cancel</a>
                    <button type="submit" class="primary-button w-full sm:w-auto inline-flex items-center justify-center gap-2 px-8 py-3 rounded-xl font-semibold text-white bg-brand-600 hover:bg-brand-700 shadow-lg shadow-brand-600/25">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 5v14M5 12h14"/></svg>
                        Schedule Appointment
                    </button>
                </div>
            </div>
        </form>
    </div>
</main>
</body>
</html>