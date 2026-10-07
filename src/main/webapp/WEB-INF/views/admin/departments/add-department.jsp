<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Create Department"/>
<c:set var="pageSubtitle" value="Add a new medical ward or department to the clinic."/>
<c:set var="activePage" value="departments"/>

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

    <form action="${pageContext.request.contextPath}/admin/departments/add" method="POST" class="form-card bg-white rounded-3xl border border-slate-200 overflow-hidden">
      <div class="px-6 sm:px-8 py-7 border-b border-slate-100 bg-gradient-to-r from-white to-brand-50/30">
        <div class="flex items-center gap-4">
          <div class="h-12 w-12 sm:h-14 sm:w-14 rounded-2xl bg-brand-50 text-brand-600 border border-brand-100 flex items-center justify-center shadow-sm">
            <svg class="h-6 w-6 sm:h-7 sm:w-7" fill="none" stroke="currentColor" stroke-width="1.8" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"/>
            </svg>
          </div>
          <div>
            <h2 class="text-lg sm:text-xl font-bold text-slate-800">Department Details</h2>
            <p class="text-sm text-slate-500 mt-1">Provide the operational name and description.</p>
          </div>
        </div>
      </div>

      <div class="p-6 sm:p-8">
        <div class="space-y-6">
          <div>
            <label class="block text-sm font-semibold text-slate-700 mb-2">Department Name</label>
            <input type="text" name="name" placeholder="e.g. Cardiology" required class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 focus:ring-2 focus:ring-brand-500 focus:bg-white transition-all outline-none">
          </div>
          <div>
            <label class="block text-sm font-semibold text-slate-700 mb-2">Description <span class="text-slate-400 font-normal">(Optional)</span></label>
            <textarea name="description" rows="4" placeholder="Briefly describe the functions of this department..." class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 focus:ring-2 focus:ring-brand-500 focus:bg-white transition-all outline-none resize-none"></textarea>
          </div>
        </div>

        <div class="flex flex-col-reverse sm:flex-row items-center justify-end gap-4 mt-10 pt-7 border-t border-slate-100">
          <a href="${pageContext.request.contextPath}/admin/departments" class="w-full sm:w-auto px-6 py-3 rounded-xl font-semibold text-slate-600 bg-slate-100 hover:bg-slate-200 transition-all text-center">Cancel</a>
          <button type="submit" class="w-full sm:w-auto inline-flex items-center justify-center gap-2 px-8 py-3 rounded-xl font-semibold text-white bg-brand-600 hover:bg-brand-700 shadow-lg shadow-brand-600/25 transition-all">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 5v14M5 12h14"/></svg>
            Create Department
          </button>
        </div>
      </div>
    </form>
  </div>
</main>
</body>
</html>