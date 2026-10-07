<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Departments Directory"/>
<c:set var="pageSubtitle" value="Manage clinic departments and medical wards."/>
<c:set var="activePage" value="departments"/>

<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/includes/head.jsp" %>
<body class="bg-slate-50 font-sans text-slate-800 antialiased flex h-screen overflow-hidden">
<%@ include file="/WEB-INF/views/includes/sidebar.jsp" %>

<main class="flex-1 flex flex-col h-screen overflow-y-auto bg-slate-50/50">
  <%@ include file="/WEB-INF/views/includes/header.jsp" %>

  <div class="p-5 sm:p-7 lg:p-10 max-w-5xl mx-auto w-full">

    <c:if test="${not empty sessionScope.successMessage}">
      <div role="alert" class="mb-8 flex items-start gap-3 rounded-2xl border border-brand-100 bg-brand-50 p-4 text-sm text-brand-800 shadow-sm">
        <svg class="mt-0.5 h-5 w-5 shrink-0 text-brand-600" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
        </svg>
        <div>
          <p class="font-bold">Success</p>
          <p><c:out value="${sessionScope.successMessage}"/></p>
        </div>
      </div>
      <c:remove var="successMessage" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.errorMessage}">
      <div role="alert" class="mb-8 flex items-start gap-3 rounded-2xl border border-red-100 bg-red-50 p-4 text-sm text-red-700 shadow-sm">
        <svg class="mt-0.5 h-5 w-5 shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v4m0 4h.01M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z"/>
        </svg>
        <div>
          <p class="font-bold">Error</p>
          <p><c:out value="${sessionScope.errorMessage}"/></p>
        </div>
      </div>
      <c:remove var="errorMessage" scope="session"/>
    </c:if>

    <div class="bg-white rounded-2xl sm:rounded-3xl shadow-sm border border-slate-200 overflow-hidden">
      <div class="px-5 sm:px-6 py-5 sm:py-6 border-b border-slate-100 flex flex-col sm:flex-row gap-4 sm:items-center sm:justify-between">
        <div class="relative w-full sm:w-auto">
          <svg class="w-5 h-5 absolute left-3 top-2.5 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
          </svg>
          <input type="text" placeholder="Search departments..." class="pl-10 pr-4 py-2.5 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-brand-500 w-full sm:w-64 transition-all">
        </div>

        <a href="${pageContext.request.contextPath}/admin/departments/add" class="bg-brand-600 hover:bg-brand-700 text-white px-5 py-2.5 rounded-xl text-sm font-semibold shadow-lg shadow-brand-600/25 transition-all flex items-center justify-center gap-2 w-full sm:w-auto">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/>
          </svg>
          Create Department
        </a>
      </div>

      <div class="overflow-x-auto w-full">
        <table class="w-full text-left border-collapse table-fixed min-w-[600px]">
          <thead>
          <tr class="bg-slate-50/80 text-slate-500 text-xs uppercase tracking-wider font-semibold">
            <th class="px-6 py-4 whitespace-nowrap w-1/4">Department Name</th>
            <th class="px-6 py-4 whitespace-nowrap w-1/2">Description</th>
            <th class="px-6 py-4 whitespace-nowrap text-right w-1/4">Actions</th>
          </tr>
          </thead>
          <tbody class="text-sm divide-y divide-slate-100 bg-white">
          <c:forEach var="dept" items="${departments}">
            <tr class="hover:bg-slate-50 transition-colors">
              <td class="px-6 py-5 whitespace-nowrap font-bold text-slate-800">
                <div class="flex items-center gap-3">
                  <div class="h-8 w-8 rounded-lg bg-blue-50 text-blue-600 flex items-center justify-center border border-blue-100 shrink-0">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"/></svg>
                  </div>
                  <c:out value="${dept.name}"/>
                </div>
              </td>

              <td class="px-6 py-5 text-slate-500 font-medium truncate max-w-[250px]" title="${dept.description}">
                <c:out value="${not empty dept.description ? dept.description : 'No description provided.'}"/>
              </td>

              <td class="px-6 py-5 whitespace-nowrap text-right">
                <div class="flex items-center justify-end gap-3">
                  <a href="${pageContext.request.contextPath}/admin/departments/edit?id=${dept.id}" class="text-slate-400 hover:text-brand-600 transition-colors" title="Edit">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"/></svg>
                  </a>
                  <form action="${pageContext.request.contextPath}/admin/departments/delete" method="POST" class="inline m-0" onsubmit="return confirm('Are you sure you want to delete this department?');">
                    <input type="hidden" name="id" value="${dept.id}">
                    <button type="submit" class="text-slate-400 hover:text-red-600 transition-colors" title="Delete">
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