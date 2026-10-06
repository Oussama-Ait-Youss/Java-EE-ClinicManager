<c:set var="pageTitle" value="Edit Doctor Profile"/>
<c:set var="pageSubtitle" value="Update doctor information and account details."/>
<c:set var="activePage" value="doctors"/>

<!DOCTYPE html>

<html lang="en">

<%@ include file="/WEB-INF/views/includes/head.jsp" %>

<body class="bg-slate-50 font-sans text-slate-800 antialiased
             flex h-screen overflow-hidden">

<%@ include file="/WEB-INF/views/includes/sidebar.jsp" %>

<main class="flex-1 flex flex-col h-screen overflow-y-auto bg-slate-50/50">

    <%@ include file="/WEB-INF/views/includes/header.jsp" %>

    <div class="p-6 md:p-10 max-w-6xl mx-auto w-full">

        <!-- ERROR -->
        <c:if test="${not empty sessionScope.errorMessage}">

            <div role="alert"
                 class="mb-8 flex items-start gap-3 rounded-2xl border border-red-100 bg-red-50 p-4 text-sm text-red-700 shadow-sm">

                <div class="h-8 w-8 rounded-lg bg-red-100 flex items-center justify-center shrink-0">

                    <svg class="h-5 w-5"
                         fill="none"
                         stroke="currentColor"
                         stroke-width="2"
                         viewBox="0 0 24 24">
                        <path stroke-linecap="round"
                              stroke-linejoin="round"
                              d="M12 9v4m0 4h.01
                                 M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z"/>
                    </svg>

                </div>

                <div>
                    <p class="font-bold">Error</p>
                    <p class="mt-0.5">
                        <c:out value="${sessionScope.errorMessage}"/>
                    </p>
                </div>

            </div>

            <c:remove var="errorMessage" scope="session"/>

        </c:if>


        <!-- FORM -->
        <form action="${pageContext.request.contextPath}/admin/doctors/edit"
              method="POST"
              class="bg-white rounded-3xl border border-slate-200 shadow-sm overflow-hidden">

            <input type="hidden" name="id" value="${doctor.id}">


            <!-- FORM HEADER -->
            <div class="px-8 py-7 border-b border-slate-100 bg-gradient-to-r from-white to-brand-50/30">

                <div class="flex items-center gap-4">

                    <div class="h-14 w-14 rounded-2xl bg-brand-50 text-brand-600 border border-brand-100 flex items-center justify-center shadow-sm">

                        <svg class="h-7 w-7"
                             fill="none"
                             stroke="currentColor"
                             stroke-width="1.8"
                             viewBox="0 0 24 24">
                            <path stroke-linecap="round"
                                  stroke-linejoin="round"
                                  d="M15.232 5.232l3.536 3.536
                                     m-2.036-5.036a2.5 2.5 0 113.536 3.536
                                     L6.5 21.036H3v-3.572L16.732 3.732z"/>
                        </svg>

                    </div>

                    <div>

                        <h2 class="text-xl font-bold text-slate-800">
                            Medical Profile
                        </h2>

                        <p class="text-sm text-slate-500 mt-1">
                            Update the doctor's professional information and account details.
                        </p>

                    </div>

                </div>

            </div>


            <!-- FORM BODY -->
            <div class="p-8 md:p-10">


                <!-- ================================================= -->
                <!-- PROFESSIONAL INFORMATION -->
                <!-- ================================================= -->

                <div class="mb-7">

                    <div class="flex items-center gap-3">

                        <div class="h-9 w-9 rounded-xl bg-brand-50 text-brand-600 flex items-center justify-center">

                            <svg class="w-5 h-5"
                                 fill="none"
                                 stroke="currentColor"
                                 stroke-width="2"
                                 viewBox="0 0 24 24">
                                <path stroke-linecap="round"
                                      stroke-linejoin="round"
                                      d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                            </svg>

                        </div>

                        <div>
                            <h3 class="font-bold text-slate-800">
                                Professional Information
                            </h3>

                            <p class="text-sm text-slate-500">
                                Information related to the doctor's medical profile.
                            </p>
                        </div>

                    </div>

                </div>


                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                    <!-- Matricule -->
                    <div>
                        <label class="block text-sm font-semibold text-slate-700 mb-2">
                            Matricule
                        </label>

                        <input type="text"
                               name="matricule"
                               value="${doctor.matricule}"
                               required
                               class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 hover:bg-white focus:bg-white outline-none"
                               placeholder="Doctor matricule">
                    </div>


                    <!-- Title + Department -->
                    <div class="grid grid-cols-3 gap-4">

                        <div>
                            <label class="block text-sm font-semibold text-slate-700 mb-2">
                                Title
                            </label>

                            <select name="title"
                                    required
                                    class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 hover:bg-white focus:bg-white outline-none">

                                <option value="Dr." <c:if test="${doctor.title == 'Dr.'}">selected</c:if>>
                                    Dr.
                                </option>

                                <option value="Pr." <c:if test="${doctor.title == 'Pr.'}">selected</c:if>>
                                    Pr.
                                </option>

                            </select>
                        </div>


                        <div class="col-span-2">

                            <label class="block text-sm font-semibold text-slate-700 mb-2">
                                Department
                            </label>

                            <select name="department_id"
                                    required
                                    class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 hover:bg-white focus:bg-white outline-none">

                                <c:forEach var="dept" items="${departments}">

                                    <option value="${dept.id}"
                                            <c:if test="${dept.id == doctor.department.id}">
                                                selected
                                            </c:if>>
                                            ${dept.name}
                                    </option>

                                </c:forEach>

                            </select>

                        </div>

                    </div>


                    <!-- Specialty -->
                    <div>

                        <label class="block text-sm font-semibold text-slate-700 mb-2">
                            Specialty
                        </label>

                        <select name="specialty_id"
                                required
                                class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 hover:bg-white focus:bg-white outline-none">

                            <c:forEach var="spec" items="${specialties}">

                                <option value="${spec.id}"
                                        <c:if test="${spec.id == doctor.specialty.id}">
                                            selected
                                        </c:if>>
                                        ${spec.name}
                                </option>

                            </c:forEach>

                        </select>

                    </div>


                    <!-- Account Status -->
                    <div>

                        <label class="block text-sm font-semibold text-slate-700 mb-2">
                            Account Status
                        </label>

                        <select name="active"
                                required
                                class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 hover:bg-white focus:bg-white outline-none">

                            <option value="true"
                                    <c:if test="${doctor.active}">selected</c:if>>
                                Active
                            </option>

                            <option value="false"
                                    <c:if test="${!doctor.active}">selected</c:if>>
                                Inactive
                            </option>

                        </select>

                    </div>

                </div>


                <!-- SEPARATOR -->
                <div class="my-10 border-t border-slate-100"></div>


                <!-- ================================================= -->
                <!-- PERSONAL INFORMATION -->
                <!-- ================================================= -->

                <div class="mb-7">

                    <div class="flex items-center gap-3">

                        <div class="h-9 w-9 rounded-xl bg-blue-50 text-blue-600 flex items-center justify-center">

                            <svg class="w-5 h-5"
                                 fill="none"
                                 stroke="currentColor"
                                 stroke-width="2"
                                 viewBox="0 0 24 24">
                                <path stroke-linecap="round"
                                      stroke-linejoin="round"
                                      d="M16 7a4 4 0 11-8 0 4 4 0 018 0z
                                         M12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                            </svg>

                        </div>

                        <div>

                            <h3 class="font-bold text-slate-800">
                                Personal & Account Information
                            </h3>

                            <p class="text-sm text-slate-500">
                                Update the doctor's personal and login information.
                            </p>

                        </div>

                    </div>

                </div>


                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                    <!-- First Name -->
                    <div>

                        <label class="block text-sm font-semibold text-slate-700 mb-2">
                            First Name
                        </label>

                        <input type="text"
                               name="first_name"
                               value="${doctor.first_name}"
                               required
                               class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 hover:bg-white focus:bg-white outline-none"
                               placeholder="First name">

                    </div>


                    <!-- Last Name -->
                    <div>

                        <label class="block text-sm font-semibold text-slate-700 mb-2">
                            Last Name
                        </label>

                        <input type="text"
                               name="last_name"
                               value="${doctor.last_name}"
                               required
                               class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 hover:bg-white focus:bg-white outline-none"
                               placeholder="Last name">

                    </div>


                    <!-- Gender -->
                    <div>

                        <label class="block text-sm font-semibold text-slate-700 mb-2">
                            Gender
                        </label>

                        <select name="gender"
                                required
                                class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 hover:bg-white focus:bg-white outline-none">

                            <option value="MALE"
                                    <c:if test="${doctor.gender == 'MALE'}">selected</c:if>>
                                Male
                            </option>

                            <option value="FEMALE"
                                    <c:if test="${doctor.gender == 'FEMALE'}">selected</c:if>>
                                Female
                            </option>

                        </select>

                    </div>


                    <!-- Phone -->
                    <div>

                        <label class="block text-sm font-semibold text-slate-700 mb-2">
                            Phone Number
                        </label>

                        <input type="tel"
                               name="phone"
                               value="${doctor.phone}"
                               required
                               class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 hover:bg-white focus:bg-white outline-none"
                               placeholder="+212 6 XX XX XX XX">

                    </div>


                    <!-- Email -->
                    <div>

                        <label class="block text-sm font-semibold text-slate-700 mb-2">
                            Email Address
                        </label>

                        <input type="email"
                               name="email"
                               value="${doctor.email}"
                               required
                               class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 hover:bg-white focus:bg-white outline-none"
                               placeholder="doctor@example.com">

                    </div>


                    <!-- Password -->
                    <div>

                        <label class="block text-sm font-semibold text-slate-700 mb-2">

                            Change Password

                            <span class="text-slate-400 font-normal">
                                (optional)
                            </span>

                        </label>

                        <input type="password"
                               name="password"
                               placeholder="Leave blank to keep current"
                               class="form-input w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50/50 hover:bg-white focus:bg-white outline-none">

                        <p class="text-xs text-slate-400 mt-2">
                            Only fill this field if you want to change the password.
                        </p>

                    </div>

                </div>


                <!-- ================================================= -->
                <!-- ACTIONS -->
                <!-- ================================================= -->

                <div class="flex flex-col-reverse sm:flex-row items-center justify-between gap-4 mt-10 pt-7 border-t border-slate-100">

                    <a href="${pageContext.request.contextPath}/admin/doctors"
                       class="w-full sm:w-auto px-6 py-3 rounded-xl font-semibold text-slate-600 bg-slate-100 hover:bg-slate-200 transition-all text-center">

                        Cancel

                    </a>


                    <button type="submit"
                            class="w-full sm:w-auto inline-flex items-center justify-center gap-2 px-8 py-3 rounded-xl font-semibold text-white bg-brand-600 hover:bg-brand-700 shadow-lg shadow-brand-600/25 hover:shadow-brand-600/35 transition-all">

                        <svg class="w-5 h-5"
                             fill="none"
                             stroke="currentColor"
                             stroke-width="2"
                             viewBox="0 0 24 24">

                            <path stroke-linecap="round"
                                  stroke-linejoin="round"
                                  d="M5 13l4 4L19 7"/>

                        </svg>

                        Save Changes

                    </button>

                </div>

            </div>

        </form>

    </div>

</main>

</body>

</html>