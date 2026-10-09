<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Medical Note Details"/>
<c:set var="pageSubtitle" value="Read-only consultation record."/>
<c:set var="activePage" value="medical_notes"/>

<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/includes/head.jsp" %>
<body class="bg-slate-50 font-sans text-slate-800 antialiased flex h-screen overflow-hidden">
<%@ include file="/WEB-INF/views/includes/sidebar.jsp" %>

<main class="flex-1 flex flex-col h-screen overflow-y-auto bg-slate-50/50">
    <%@ include file="/WEB-INF/views/includes/header.jsp" %>

    <div class="p-5 sm:p-7 lg:p-10 max-w-5xl mx-auto w-full">
        <div class="mb-6 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
            <div>
                <p class="text-xs font-bold uppercase tracking-wider text-brand-600">Consultation record · #<c:out value="${medicalNote.id}"/></p>
                <h2 class="mt-1 text-2xl font-bold tracking-tight text-slate-900">Medical Note</h2>
            </div>
            <a href="${pageContext.request.contextPath}/admin/medical-notes"
               class="inline-flex items-center justify-center gap-2 rounded-xl border border-slate-200 bg-white px-4 py-2.5 text-sm font-semibold text-slate-600 shadow-sm hover:border-brand-200 hover:text-brand-700 transition-colors">
                <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
                </svg>
                Back to Notes
            </a>
        </div>

        <div class="overflow-hidden rounded-3xl border border-slate-200 bg-white shadow-sm">
            <div class="relative overflow-hidden border-b border-slate-100 bg-gradient-to-br from-brand-50 via-white to-blue-50 px-6 py-7 sm:px-8">
                <div class="absolute -right-10 -top-14 h-48 w-48 rounded-full bg-brand-200/30 blur-3xl"></div>
                <div class="relative grid gap-5 sm:grid-cols-2">
                    <div class="rounded-2xl border border-white/80 bg-white/75 p-5 shadow-sm backdrop-blur">
                        <p class="text-xs font-bold uppercase tracking-wider text-slate-400">Patient</p>
                        <p class="mt-2 text-lg font-bold text-slate-800">
                            <c:out value="${medicalNote.appointment.patient.first_name} ${medicalNote.appointment.patient.last_name}"/>
                        </p>
                    </div>
                    <div class="rounded-2xl border border-white/80 bg-white/75 p-5 shadow-sm backdrop-blur">
                        <p class="text-xs font-bold uppercase tracking-wider text-slate-400">Doctor</p>
                        <p class="mt-2 text-lg font-bold text-slate-800">
                            <c:out value="${medicalNote.appointment.doctor.title} ${medicalNote.appointment.doctor.first_name} ${medicalNote.appointment.doctor.last_name}"/>
                        </p>
                    </div>
                    <div class="rounded-2xl border border-white/80 bg-white/75 p-5 shadow-sm backdrop-blur">
                        <p class="text-xs font-bold uppercase tracking-wider text-slate-400">Appointment</p>
                        <p class="mt-2 font-semibold text-slate-800">
                            <c:out value="${medicalNote.appointment.appointmentDate}"/> ·
                            <c:out value="${medicalNote.appointment.appointmentTime}"/>
                        </p>
                    </div>
                    <div class="rounded-2xl border border-white/80 bg-white/75 p-5 shadow-sm backdrop-blur">
                        <p class="text-xs font-bold uppercase tracking-wider text-slate-400">Appointment status</p>
                        <span class="mt-2 inline-flex items-center gap-2 rounded-full bg-emerald-50 px-3 py-1 text-sm font-bold text-emerald-700 ring-1 ring-inset ring-emerald-200">
                            <span class="h-2 w-2 rounded-full bg-emerald-500"></span>
                            <c:out value="${medicalNote.appointment.status}"/>
                        </span>
                    </div>
                </div>
            </div>

            <div class="space-y-7 px-6 py-7 sm:px-8">
                <div>
                    <div class="flex items-center justify-between gap-4">
                        <h3 class="text-sm font-bold uppercase tracking-wider text-slate-500">Diagnostic</h3>
                        <span class="text-xs font-medium text-slate-400">Recorded <c:out value="${medicalNote.noteDate}"/></span>
                    </div>
                    <p class="mt-3 rounded-2xl border border-brand-100 bg-brand-50/70 px-5 py-4 text-base font-semibold text-brand-900">
                        <c:out value="${medicalNote.diagnostic}"/>
                    </p>
                </div>

                <div>
                    <h3 class="text-sm font-bold uppercase tracking-wider text-slate-500">Medical note</h3>
                    <div class="mt-3 min-h-48 whitespace-pre-wrap rounded-2xl border border-slate-200 bg-slate-50/70 px-5 py-5 text-sm leading-7 text-slate-700"><c:out value="${medicalNote.content}"/></div>
                </div>

                <div class="flex items-center gap-3 rounded-2xl border border-slate-200 bg-white px-4 py-3 text-sm text-slate-500">
                    <svg class="h-5 w-5 shrink-0 text-slate-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/>
                    </svg>
                    This consultation note is read-only and cannot be edited.
                </div>
            </div>
        </div>
    </div>
</main>
</body>
</html>
