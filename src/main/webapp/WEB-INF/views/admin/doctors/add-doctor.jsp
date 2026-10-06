<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Register Medical Staff"/>
<c:set var="pageSubtitle" value="Create a new doctor account and assign their specialty."/>
<c:set var="activePage" value="doctors"/>

<!DOCTYPE html>

<html lang="en">

<%@ include file="/WEB-INF/views/includes/head.jsp" %>


<body class="bg-slate-50 font-sans text-slate-800 antialiased
             flex h-screen overflow-hidden">


<!-- ========================================================= -->
<!-- SIDEBAR -->
<!-- ========================================================= -->

<%@ include file="/WEB-INF/views/includes/sidebar.jsp" %>


<!-- ========================================================= -->
<!-- MAIN -->
<!-- ========================================================= -->

<main class="flex-1 flex flex-col h-screen overflow-y-auto bg-slate-50/50">


    <!-- ===================================================== -->
    <!-- HEADER -->
    <!-- ===================================================== -->

    <%@ include file="/WEB-INF/views/includes/header.jsp" %>


    <!-- ===================================================== -->
    <!-- PAGE CONTENT -->
    <!-- ===================================================== -->

    <div class="p-4 sm:p-6 lg:p-10 max-w-6xl mx-auto w-full">


        <!-- ================================================= -->
        <!-- ERROR MESSAGE -->
        <!-- ================================================= -->

        <c:if test="${not empty errorMessage}">

            <div role="alert"
                 class="mb-8 flex items-start gap-3
                        rounded-2xl border border-red-100
                        bg-red-50 p-4
                        text-sm text-red-700 shadow-sm">

                <div class="h-8 w-8 rounded-lg
                            bg-red-100
                            flex items-center justify-center
                            shrink-0">

                    <svg class="h-5 w-5"
                         fill="none"
                         stroke="currentColor"
                         stroke-width="2"
                         viewBox="0 0 24 24">

                        <path stroke-linecap="round"
                              stroke-linejoin="round"
                              d="M12 9v4m0 4h.01
                                 M10.29 3.86L1.82 18
                                 a2 2 0 001.71 3h16.94
                                 a2 2 0 001.71-3L13.71 3.86
                                 a2 2 0 00-3.42 0z"/>

                    </svg>

                </div>

                <div>

                    <p class="font-bold">
                        Error
                    </p>

                    <p class="mt-0.5">
                        <c:out value="${errorMessage}"/>
                    </p>

                </div>

            </div>

            <c:remove var="errorMessage" scope="request"/>

        </c:if>


        <!-- ================================================= -->
        <!-- FORM -->
        <!-- ================================================= -->

        <form action="${pageContext.request.contextPath}/admin/doctors/add"
              method="POST"
              class="form-card bg-white rounded-3xl
                     border border-slate-200 overflow-hidden">


            <!-- ================================================= -->
            <!-- FORM HEADER -->
            <!-- ================================================= -->

            <div class="px-6 sm:px-8 py-7
                        border-b border-slate-100
                        bg-gradient-to-r from-white to-brand-50/30">

                <div class="flex items-center gap-4">

                    <div class="h-12 w-12 sm:h-14 sm:w-14
                                rounded-2xl
                                bg-brand-50
                                text-brand-600
                                border border-brand-100
                                flex items-center justify-center
                                shadow-sm">

                        <svg class="h-6 w-6 sm:h-7 sm:w-7"
                             fill="none"
                             stroke="currentColor"
                             stroke-width="1.8"
                             viewBox="0 0 24 24">

                            <path stroke-linecap="round"
                                  stroke-linejoin="round"
                                  d="M12 5v14
                                     M5 12h14"/>

                        </svg>

                    </div>

                    <div>

                        <h2 class="text-lg sm:text-xl
                                   font-bold text-slate-800">

                            Medical Profile

                        </h2>

                        <p class="text-sm text-slate-500 mt-1">

                            Enter the professional information
                            of the new doctor.

                        </p>

                    </div>

                </div>

            </div>


            <!-- ================================================= -->
            <!-- FORM BODY -->
            <!-- ================================================= -->

            <div class="p-6 sm:p-8 lg:p-10">


                <!-- ================================================= -->
                <!-- PROFESSIONAL INFORMATION -->
                <!-- ================================================= -->

                <div class="mb-7">

                    <div class="flex items-center gap-3">

                        <div class="h-9 w-9 rounded-xl
                                    bg-brand-50
                                    text-brand-600
                                    flex items-center justify-center">

                            <svg class="w-5 h-5"
                                 fill="none"
                                 stroke="currentColor"
                                 stroke-width="2"
                                 viewBox="0 0 24 24">

                                <path stroke-linecap="round"
                                      stroke-linejoin="round"
                                      d="M9 12h6
                                         m-6 4h6
                                         m2 5H7a2 2 0 01-2-2V5
                                         a2 2 0 012-2h5.586
                                         a1 1 0 01.707.293
                                         l5.414 5.414
                                         a1 1 0 01.293.707V19
                                         a2 2 0 01-2 2z"/>

                            </svg>

                        </div>

                        <div>

                            <h3 class="font-bold text-slate-800">
                                Professional Information
                            </h3>

                            <p class="text-sm text-slate-500">
                                Information related to the doctor's
                                medical profile.
                            </p>

                        </div>

                    </div>

                </div>


                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">


                    <!-- MATRICULE -->

                    <div>

                        <label class="block text-sm font-semibold
                                      text-slate-700 mb-2">

                            Matricule

                        </label>

                        <input type="text"
                               name="matricule"
                               placeholder="e.g. DOC-002"
                               required
                               class="form-input w-full px-4 py-3
                                      rounded-xl
                                      border border-slate-200
                                      bg-slate-50/50">

                    </div>


                    <!-- TITLE -->

                    <div>

                        <label class="block text-sm font-semibold
                                      text-slate-700 mb-2">

                            Title

                        </label>

                        <select name="title"
                                required
                                class="form-input w-full px-4 py-3
                                       rounded-xl
                                       border border-slate-200
                                       bg-slate-50/50">

                            <option value="Dr.">
                                Dr.
                            </option>

                            <option value="Pr.">
                                Pr.
                            </option>

                        </select>

                    </div>


                    <!-- DEPARTMENT -->

                    <div>

                        <label class="block text-sm font-semibold
                                      text-slate-700 mb-2">

                            Department

                        </label>

                        <select name="department_id"
                                required
                                class="form-input w-full px-4 py-3
                                       rounded-xl
                                       border border-slate-200
                                       bg-slate-50/50">

                            <option value="" disabled selected>
                                Select Department
                            </option>

                            <c:forEach var="dept"
                                       items="${departments}">

                                <option value="${dept.id}">
                                        ${dept.name}
                                </option>

                            </c:forEach>

                        </select>

                    </div>


                    <!-- SPECIALTY -->

                    <div>

                        <label class="block text-sm font-semibold
                                      text-slate-700 mb-2">

                            Specialty

                        </label>

                        <select name="specialty_id"
                                required
                                class="form-input w-full px-4 py-3
                                       rounded-xl
                                       border border-slate-200
                                       bg-slate-50/50">

                            <option value="" disabled selected>
                                Select Specialty
                            </option>

                            <c:forEach var="spec"
                                       items="${specialties}">

                                <option value="${spec.id}">
                                        ${spec.name}
                                </option>

                            </c:forEach>

                        </select>

                    </div>

                </div>


                <!-- ================================================= -->
                <!-- SEPARATOR -->
                <!-- ================================================= -->

                <div class="my-10 border-t border-slate-100"></div>


                <!-- ================================================= -->
                <!-- PERSONAL INFORMATION -->
                <!-- ================================================= -->

                <div class="mb-7">

                    <div class="flex items-center gap-3">

                        <div class="h-9 w-9 rounded-xl
                                    bg-blue-50
                                    text-blue-600
                                    flex items-center justify-center">

                            <svg class="w-5 h-5"
                                 fill="none"
                                 stroke="currentColor"
                                 stroke-width="2"
                                 viewBox="0 0 24 24">

                                <path stroke-linecap="round"
                                      stroke-linejoin="round"
                                      d="M16 7a4 4 0 11-8 0
                                         4 4 0 018 0z
                                         M12 14a7 7 0 00-7 7
                                         h14a7 7 0 00-7-7z"/>

                            </svg>

                        </div>

                        <div>

                            <h3 class="font-bold text-slate-800">

                                Personal & Account Information

                            </h3>

                            <p class="text-sm text-slate-500">

                                Enter the doctor's personal
                                and login information.

                            </p>

                        </div>

                    </div>

                </div>


                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">


                    <!-- FIRST NAME -->

                    <div>

                        <label class="block text-sm font-semibold
                                      text-slate-700 mb-2">

                            First Name

                        </label>

                        <input type="text"
                               name="first_name"
                               placeholder="First name"
                               required
                               class="form-input w-full px-4 py-3
                                      rounded-xl
                                      border border-slate-200
                                      bg-slate-50/50">

                    </div>


                    <!-- LAST NAME -->

                    <div>

                        <label class="block text-sm font-semibold
                                      text-slate-700 mb-2">

                            Last Name

                        </label>

                        <input type="text"
                               name="last_name"
                               placeholder="Last name"
                               required
                               class="form-input w-full px-4 py-3
                                      rounded-xl
                                      border border-slate-200
                                      bg-slate-50/50">

                    </div>


                    <!-- GENDER -->

                    <div>

                        <label class="block text-sm font-semibold
                                      text-slate-700 mb-2">

                            Gender

                        </label>

                        <select name="gender"
                                required
                                class="form-input w-full px-4 py-3
                                       rounded-xl
                                       border border-slate-200
                                       bg-slate-50/50">

                            <option value="MALE">
                                Male
                            </option>

                            <option value="FEMALE">
                                Female
                            </option>

                        </select>

                    </div>


                    <!-- PHONE -->

                    <div>

                        <label class="block text-sm font-semibold
                                      text-slate-700 mb-2">

                            Phone Number

                        </label>

                        <input type="tel"
                               name="phone"
                               placeholder="+212 6 XX XX XX XX"
                               required
                               class="form-input w-full px-4 py-3
                                      rounded-xl
                                      border border-slate-200
                                      bg-slate-50/50">

                    </div>


                    <!-- EMAIL -->

                    <div>

                        <label class="block text-sm font-semibold
                                      text-slate-700 mb-2">

                            Email Address

                        </label>

                        <input type="email"
                               name="email"
                               placeholder="doctor@example.com"
                               required
                               class="form-input w-full px-4 py-3
                                      rounded-xl
                                      border border-slate-200
                                      bg-slate-50/50">

                    </div>


                    <!-- PASSWORD -->

                    <div>

                        <label class="block text-sm font-semibold
                                      text-slate-700 mb-2">

                            Temporary Password

                        </label>

                        <input type="password"
                               name="password"
                               placeholder="Enter temporary password"
                               required
                               class="form-input w-full px-4 py-3
                                      rounded-xl
                                      border border-slate-200
                                      bg-slate-50/50">

                        <p class="text-xs text-slate-400 mt-2">

                            The doctor can change this password later.

                        </p>

                    </div>

                </div>


                <!-- ================================================= -->
                <!-- ACTIONS -->
                <!-- ================================================= -->

                <div class="flex flex-col-reverse sm:flex-row
                            items-center justify-between
                            gap-4 mt-10 pt-7
                            border-t border-slate-100">


                    <!-- CANCEL -->

                    <a href="${pageContext.request.contextPath}/admin/doctors"
                       class="w-full sm:w-auto
                              px-6 py-3 rounded-xl
                              font-semibold
                              text-slate-600
                              bg-slate-100
                              hover:bg-slate-200
                              transition-all
                              text-center">

                        Cancel

                    </a>


                    <!-- SUBMIT -->

                    <button type="submit"
                            class="primary-button
                                   w-full sm:w-auto
                                   inline-flex
                                   items-center
                                   justify-center
                                   gap-2
                                   px-8 py-3
                                   rounded-xl
                                   font-semibold
                                   text-white
                                   bg-brand-600
                                   hover:bg-brand-700
                                   shadow-lg
                                   shadow-brand-600/25">

                        <svg class="w-5 h-5"
                             fill="none"
                             stroke="currentColor"
                             stroke-width="2"
                             viewBox="0 0 24 24">

                            <path stroke-linecap="round"
                                  stroke-linejoin="round"
                                  d="M12 5v14
                                     M5 12h14"/>

                        </svg>

                        Register Doctor

                    </button>

                </div>

            </div>

        </form>

    </div>

</main>

</body>

</html>
