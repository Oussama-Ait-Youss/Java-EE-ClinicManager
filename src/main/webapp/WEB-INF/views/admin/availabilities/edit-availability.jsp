<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Edit Availability"/>
<c:set var="pageSubtitle" value="Update a doctor's shift and schedule validity."/>
<c:set var="activePage" value="availabilities"/>

<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/includes/head.jsp" %>
<body class="bg-slate-50 font-sans text-slate-800 antialiased flex h-screen overflow-hidden">
<%@ include file="/WEB-INF/views/includes/sidebar.jsp" %>

<main class="flex-1 flex flex-col h-screen overflow-y-auto bg-slate-50/50">
  <%@ include file="/WEB-INF/views/includes/header.jsp" %>

  <div class="p-4 sm:p-6 lg:p-10 max-w-3xl mx-auto w-full">
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

    <form action="${pageContext.request.contextPath}/admin/availabilities/edit" method="POST" class="form-card bg-white rounded-3xl border border-slate-200 overflow-hidden">
      <input type="hidden" name="id" value="${availability.id}">

      <div class="px-6 sm:px-8 py-7 border-b border-slate-100 bg-gradient-to-r from-white to-brand-50/30">
        <div class="flex items-center gap-4">
          <div class="h-12 w-12 sm:h-14 sm:w-14 rounded-2xl bg-brand-50 text-brand-600 border border-brand-100 flex items-center justify-center shadow-sm">
            <svg class="h-6 w-6 sm:h-7 sm:w-7" fill="none" stroke="currentColor" stroke-width="1.8" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"/>
            </svg>
          </div>
          <div>
            <h2 class="text-lg sm:text-xl font-bold text-slate-800">Edit Availability</h2>
            <p class="text-sm text-slate-500 mt-1">Update the doctor, shift hours, status, or active dates.</p>
          </div>
        </div>
      </div>

      <div class="p-6 sm:p-8">
        <div class="space-y-6">
          <div>
            <label for="doctorId" class="block text-sm font-semibold text-slate-700 mb-2">Doctor</label>
            <select id="doctorId" name="doctorId" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 focus:ring-2 focus:ring-brand-500 focus:bg-white transition-all outline-none">
              <option value="">Select a doctor</option>
              <c:forEach var="doctor" items="${doctors}">
                <option value="${doctor.id}" ${availability.doctor.id == doctor.id ? 'selected' : ''}>
                  <c:out value="${doctor.title} ${doctor.first_name} ${doctor.last_name}"/>
                </option>
              </c:forEach>
            </select>
          </div>

          <div>
            <label for="dayOfWeek" class="block text-sm font-semibold text-slate-700 mb-2">Day of Week</label>
            <select id="dayOfWeek" name="dayOfWeek" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 focus:ring-2 focus:ring-brand-500 focus:bg-white transition-all outline-none">
              <option value="">Select a day</option>
              <c:forEach var="day" items="${daysOfWeek}">
                <option value="${day}" ${availability.dayOfWeek == day ? 'selected' : ''}><c:out value="${day}"/></option>
              </c:forEach>
            </select>
          </div>

          <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
            <div>
              <label for="startTime" class="block text-sm font-semibold text-slate-700 mb-2">Start Time</label>
              <input id="startTime" type="time" name="startTime" value="${availability.startTime}" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 focus:ring-2 focus:ring-brand-500 focus:bg-white transition-all outline-none">
            </div>
            <div>
              <label for="endTime" class="block text-sm font-semibold text-slate-700 mb-2">End Time</label>
              <input id="endTime" type="time" name="endTime" value="${availability.endTime}" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 focus:ring-2 focus:ring-brand-500 focus:bg-white transition-all outline-none">
            </div>
          </div>

          <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
            <div>
              <label for="validityStart" class="block text-sm font-semibold text-slate-700 mb-2">Validity Start</label>
              <input id="validityStart" type="date" name="validityStart" value="${availability.validityStart}" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 focus:ring-2 focus:ring-brand-500 focus:bg-white transition-all outline-none">
            </div>
            <div>
              <label for="validityEnd" class="block text-sm font-semibold text-slate-700 mb-2">Validity End</label>
              <input id="validityEnd" type="date" name="validityEnd" value="${availability.validityEnd}" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 focus:ring-2 focus:ring-brand-500 focus:bg-white transition-all outline-none">
            </div>
          </div>

          <div>
            <label for="status" class="block text-sm font-semibold text-slate-700 mb-2">Status</label>
            <select id="status" name="status" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 focus:ring-2 focus:ring-brand-500 focus:bg-white transition-all outline-none">
              <option value="">Select a status</option>
              <c:forEach var="availabilityStatus" items="${availabilityStatuses}">
                <option value="${availabilityStatus}" ${availability.status == availabilityStatus ? 'selected' : ''}><c:out value="${availabilityStatus}"/></option>
              </c:forEach>
            </select>
          </div>
        </div>

        <div class="flex flex-col-reverse sm:flex-row items-center justify-end gap-4 mt-10 pt-7 border-t border-slate-100">
          <a href="${pageContext.request.contextPath}/admin/availabilities" class="w-full sm:w-auto px-6 py-3 rounded-xl font-semibold text-slate-600 bg-slate-100 hover:bg-slate-200 transition-all text-center">Cancel</a>
          <button type="submit" class="w-full sm:w-auto inline-flex items-center justify-center gap-2 px-8 py-3 rounded-xl font-semibold text-white bg-brand-600 hover:bg-brand-700 shadow-lg shadow-brand-600/25 transition-all">
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
