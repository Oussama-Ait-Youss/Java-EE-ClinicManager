<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Doctors Directory"/>
<c:set var="pageSubtitle" value="View and manage all registered medical professionals."/>
<c:set var="activePage" value="doctors"/>

<!DOCTYPE html>

<html lang="en">

<%@ include file="/WEB-INF/views/includes/head.jsp" %>

<body class="bg-slate-50 font-sans text-slate-800 antialiased flex h-screen overflow-hidden">

<!-- ===================================================== -->
<!-- NAVBAR -->
<!-- ===================================================== -->

<%@ include file="/WEB-INF/views/includes/sidebar.jsp" %>


<!-- ===================================================== -->
<!-- MAIN -->
<!-- ===================================================== -->

<main class="flex-1 flex flex-col h-screen overflow-y-auto bg-slate-50/50">

    <!-- HEADER -->

    <%@ include file="/WEB-INF/views/includes/header.jsp" %>


    <!-- ================================================= -->
    <!-- PAGE CONTENT -->
    <!-- ================================================= -->

    <div class="p-5 sm:p-7 lg:p-10 max-w-7xl mx-auto w-full">

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


        <!-- ================================================= -->
        <!-- DOCTORS CARD -->
        <!-- ================================================= -->

        <div class="bg-white rounded-2xl sm:rounded-3xl
                    shadow-sm border border-slate-200
                    overflow-hidden">


            <!-- CARD HEADER -->

            <div class="px-5 sm:px-6 py-5 sm:py-6
                        border-b border-slate-100
                        flex flex-col sm:flex-row
                        gap-4 sm:items-center
                        sm:justify-between">


                <!-- SEARCH -->

                <div class="relative w-full sm:w-auto">

                    <svg class="w-5 h-5 absolute left-3 top-2.5 text-slate-400"
                         fill="none"
                         stroke="currentColor"
                         viewBox="0 0 24 24">

                        <path stroke-linecap="round"
                              stroke-linejoin="round"
                              stroke-width="2"
                              d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>

                    </svg>

                    <input type="text"
                           placeholder="Search doctors..."
                           class="pl-10 pr-4 py-2.5
                                  border border-slate-200
                                  rounded-xl text-sm
                                  focus:outline-none
                                  focus:ring-2 focus:ring-brand-500
                                  w-full sm:w-64
                                  transition-all">

                </div>


                <!-- ADD DOCTOR -->

                <a href="${pageContext.request.contextPath}/admin/doctors/add"
                   class="bg-brand-600 hover:bg-brand-700
                          text-white
                          px-5 py-2.5
                          rounded-xl text-sm font-semibold
                          shadow-lg shadow-brand-600/25
                          transition-all
                          flex items-center justify-center gap-2
                          w-full sm:w-auto">

                    <svg class="w-4 h-4"
                         fill="none"
                         stroke="currentColor"
                         stroke-width="2.5"
                         viewBox="0 0 24 24">

                        <path stroke-linecap="round"
                              stroke-linejoin="round"
                              d="M12 4v16m8-8H4"/>

                    </svg>

                    Register New Doctor

                </a>

            </div>


            <!-- ================================================= -->
            <!-- TABLE -->
            <!-- ================================================= -->

            <div class="overflow-x-auto w-full">

                <table class="w-full text-left border-collapse min-w-[900px]">

                    <thead>

                    <tr class="bg-slate-50/80
                               text-slate-500
                               text-xs uppercase
                               tracking-wider
                               font-semibold">

                        <th class="px-6 py-4 whitespace-nowrap">
                            Matricule
                        </th>

                        <th class="px-6 py-4 whitespace-nowrap">
                            Name & Title
                        </th>

                        <th class="px-6 py-4 whitespace-nowrap">
                            Department
                        </th>

                        <th class="px-6 py-4 whitespace-nowrap">
                            Specialty
                        </th>

                        <th class="px-6 py-4 whitespace-nowrap">
                            Status
                        </th>

                        <th class="px-6 py-4 whitespace-nowrap text-right">
                            Actions
                        </th>

                    </tr>

                    </thead>


                    <tbody class="text-sm divide-y divide-slate-100 bg-white">


                    <c:forEach var="doctor" items="${doctors}">

                        <tr class="hover:bg-slate-50 transition-colors">


                            <!-- MATRICULE -->

                            <td class="px-6 py-5
                                       text-slate-500
                                       font-mono text-xs
                                       font-bold whitespace-nowrap">

                                <c:out value="${doctor.matricule}"/>

                            </td>


                            <!-- NAME -->

                            <td class="px-6 py-5 whitespace-nowrap">

                                <div class="flex items-center gap-3">

                                    <div class="h-9 w-9
                                                rounded-full
                                                bg-brand-50
                                                flex items-center
                                                justify-center
                                                font-bold
                                                text-brand-700
                                                text-xs uppercase
                                                border border-brand-100
                                                shrink-0">

                                        <c:out value="${not empty doctor.first_name
                                            ? doctor.first_name.substring(0,1)
                                            : '-'}"/>

                                        <c:out value="${not empty doctor.last_name
                                            ? doctor.last_name.substring(0,1)
                                            : '-'}"/>

                                    </div>


                                    <div class="max-w-[180px] lg:max-w-[250px]">

                                        <p class="font-semibold text-slate-800 truncate"
                                           title="${doctor.title} ${doctor.first_name} ${doctor.last_name}">

                                            <c:out value="${doctor.title}
                                                ${doctor.first_name}
                                                ${doctor.last_name}"/>

                                        </p>

                                        <p class="text-xs text-slate-400
                                                  mt-0.5 truncate"
                                           title="${doctor.email}">

                                            <c:out value="${doctor.email}"/>

                                        </p>

                                    </div>

                                </div>

                            </td>


                            <!-- DEPARTMENT -->

                            <td class="px-6 py-5
                                       text-slate-600
                                       font-medium whitespace-nowrap">

                                <c:out value="${not empty doctor.department
                                    ? doctor.department.name
                                    : 'Not Assigned'}"/>

                            </td>


                            <!-- SPECIALTY -->

                            <td class="px-6 py-5
                                       text-slate-600
                                       font-medium whitespace-nowrap">

                                <c:out value="${not empty doctor.specialty
                                    ? doctor.specialty.name
                                    : 'Not Assigned'}"/>

                            </td>


                            <!-- STATUS -->

                            <td class="px-6 py-5 whitespace-nowrap">

                                <c:choose>

                                    <c:when test="${doctor.active}">

                                        <span class="inline-flex items-center
                                                     px-2.5 py-1
                                                     rounded-md
                                                     text-xs font-bold
                                                     bg-emerald-50
                                                     text-emerald-700
                                                     border border-emerald-100">

                                            <span class="w-1.5 h-1.5
                                                         rounded-full
                                                         bg-emerald-500
                                                         mr-1.5">
                                            </span>

                                            Active

                                        </span>

                                    </c:when>


                                    <c:otherwise>

                                        <span class="inline-flex items-center
                                                     px-2.5 py-1
                                                     rounded-md
                                                     text-xs font-bold
                                                     bg-slate-100
                                                     text-slate-600
                                                     border border-slate-200">

                                            <span class="w-1.5 h-1.5
                                                         rounded-full
                                                         bg-slate-400
                                                         mr-1.5">
                                            </span>

                                            Inactive

                                        </span>

                                    </c:otherwise>

                                </c:choose>

                            </td>


                            <!-- ACTIONS -->

                            <td class="px-6 py-5
                                       whitespace-nowrap text-right">

                                <div class="flex items-center
                                            justify-end gap-3">


                                    <!-- EDIT -->

                                    <a href="${pageContext.request.contextPath}/admin/doctors/edit?id=${doctor.id}"
                                       class="text-slate-400
                                              hover:text-brand-600
                                              transition-colors"
                                       title="Edit">

                                        <svg class="w-5 h-5"
                                             fill="none"
                                             stroke="currentColor"
                                             stroke-width="2"
                                             viewBox="0 0 24 24">

                                            <path stroke-linecap="round"
                                                  stroke-linejoin="round"
                                                  d="M15.232 5.232l3.536 3.536
                                                     m-2.036-5.036a2.5 2.5
                                                     0 113.536 3.536L6.5
                                                     21.036H3v-3.572L16.732
                                                     3.732z"/>

                                        </svg>

                                    </a>


                                    <!-- DELETE -->

                                    <form action="${pageContext.request.contextPath}/admin/doctors/delete"
                                          method="POST"
                                          class="inline m-0"
                                          onsubmit="return confirm('Are you sure you want to disable or delete this doctor?');">

                                        <input type="hidden"
                                               name="id"
                                               value="${doctor.id}">

                                        <button type="submit"
                                                class="text-slate-400
                                                       hover:text-red-600
                                                       transition-colors"
                                                title="Delete">

                                            <svg class="w-5 h-5"
                                                 fill="none"
                                                 stroke="currentColor"
                                                 stroke-width="2"
                                                 viewBox="0 0 24 24">

                                                <path stroke-linecap="round"
                                                      stroke-linejoin="round"
                                                      d="M19 7l-.867 12.142
                                                         A2 2 0 0116.138 21H7.862
                                                         a2 2 0 01-1.995-1.858L5
                                                         7m5 4v6m4-6v6m1-10V4
                                                         a1 1 0 00-1-1h-4a1 1 0
                                                         00-1 1v3M4 7h16"/>

                                            </svg>

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

