<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ClinicManager - Staff Login</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700&display=swap" rel="stylesheet">

    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: { sans: ['Figtree', 'ui-sans-serif', 'system-ui', 'sans-serif'] },
                    colors: {
                        brand: { 50: '#effaf8', 100: '#d3f3ee', 500: '#14a395', 600: '#0d8579', 700: '#0b6b62', 900: '#0b3b3a' }
                    }
                }
            }
        };
    </script>
    <style>
        /* Subtle medical-cross pattern for the left panel */
        .pattern-cross {
            background-image:
                    linear-gradient(rgba(255,255,255,.06) 2px, transparent 2px),
                    linear-gradient(90deg, rgba(255,255,255,.06) 2px, transparent 2px);
            background-size: 36px 36px;
        }
    </style>
</head>
<body class="min-h-screen bg-slate-100 font-sans text-slate-800 antialiased">

<main class="min-h-screen flex items-center justify-center p-4 sm:p-6">

    <div class="w-full max-w-5xl bg-white rounded-3xl shadow-xl overflow-hidden grid md:grid-cols-2">

        <!-- ===== Left brand panel (desktop only) ===== -->
        <section class="hidden md:flex relative flex-col justify-between bg-brand-900 text-white p-10 lg:p-12 pattern-cross">

            <!-- Logo -->
            <div class="flex items-center gap-3">
                <span class="flex h-11 w-11 items-center justify-center rounded-xl bg-white text-brand-700">
                    <svg class="h-6 w-6" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 5v14M5 12h14"/>
                    </svg>
                </span>
                <span class="text-xl font-bold tracking-tight">ClinicManager</span>
            </div>

            <!-- Headline + features -->
            <div>
                <h2 class="text-3xl lg:text-4xl font-bold leading-tight max-w-sm">
                    One workspace for every ward, doctor and patient file
                </h2>

                <ul class="mt-8 space-y-5">
                    <li class="flex items-start gap-4">
                        <span class="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-white/10">
                            <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M8 7V3m8 4V3M4 11h16M5 21h14a1 1 0 001-1V7a1 1 0 00-1-1H5a1 1 0 00-1 1v13a1 1 0 001 1z"/>
                            </svg>
                        </span>
                        <div>
                            <p class="font-semibold">Appointments</p>
                            <p class="text-sm text-white/70">Schedules, admissions and consultations in real time.</p>
                        </div>
                    </li>
                    <li class="flex items-start gap-4">
                        <span class="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-white/10">
                            <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                            </svg>
                        </span>
                        <div>
                            <p class="font-semibold">Medical records</p>
                            <p class="text-sm text-white/70">Notes, prescriptions and test results in one patient file.</p>
                        </div>
                    </li>
                    <li class="flex items-start gap-4">
                        <span class="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-white/10">
                            <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/>
                            </svg>
                        </span>
                        <div>
                            <p class="font-semibold">Secure access</p>
                            <p class="text-sm text-white/70">Patient data is only visible to authorized hospital staff.</p>
                        </div>
                    </li>
                </ul>
            </div>

            <p class="text-xs text-white/50">&copy; ClinicManager Hospital System</p>
        </section>

        <!-- ===== Right login panel ===== -->
        <section class="flex flex-col justify-center px-6 py-10 sm:px-12 lg:px-16">
            <div class="w-full max-w-sm mx-auto">

                <!-- Logo (mobile only, since the left panel is hidden) -->
                <div class="md:hidden flex items-center gap-3 mb-8">
                    <span class="flex h-10 w-10 items-center justify-center rounded-xl bg-brand-600 text-white">
                        <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 5v14M5 12h14"/>
                        </svg>
                    </span>
                    <span class="text-lg font-bold tracking-tight text-slate-900">ClinicManager</span>
                </div>

                <h1 class="text-3xl font-bold text-slate-900">Clinic - Manager</h1>
                <p class="mt-2 mb-8 text-sm leading-relaxed text-slate-500">
                    Sign in with your hospital account to access appointments, patient records and medical notes.
                </p>

                <!-- Error message -->
                <c:if test="${not empty errorMessage}">
                    <div role="alert" class="mb-6 flex items-start gap-3 rounded-xl border border-red-100 bg-red-50 p-3 text-sm text-red-700">
                        <svg class="mt-0.5 h-5 w-5 shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v4m0 4h.01M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z"/>
                        </svg>
                        <span><c:out value="${errorMessage}"/></span>
                    </div>
                </c:if>

                <form method="post" action="${pageContext.request.contextPath}/login" class="space-y-5">

                    <!-- Email -->
                    <div>
                        <label for="email" class="block text-sm font-semibold text-slate-800 mb-1.5">Email</label>
                        <div class="relative">
                            <span class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-slate-400">
                                <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" aria-hidden="true">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                                </svg>
                            </span>
                            <input type="email" id="email" name="email" autocomplete="username" required
                                   value="<c:out value='${enteredEmail}'/>"
                                   placeholder="name@hospital.com"
                                   class="w-full rounded-xl border border-slate-200 py-3 pl-11 pr-4 text-sm placeholder-slate-400 transition focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/30">
                        </div>
                    </div>

                    <!-- Password -->
                    <div>
                        <div class="flex items-center justify-between mb-1.5">
                            <label for="password" class="block text-sm font-semibold text-slate-800">Password</label>
                            <a href="#" class="text-xs font-medium text-brand-600 hover:text-brand-700 hover:underline">Forgot password?</a>
                        </div>
                        <div class="relative">
                            <span class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-slate-400">
                                <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" aria-hidden="true">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/>
                                </svg>
                            </span>
                            <input type="password" id="password" name="password" autocomplete="current-password" required
                                   placeholder="Enter your password"
                                   class="w-full rounded-xl border border-slate-200 py-3 pl-11 pr-12 text-sm placeholder-slate-400 transition focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/30">
                            <button type="button" id="togglePassword" aria-label="Show password" aria-pressed="false"
                                    class="absolute inset-y-0 right-0 flex items-center px-3.5 text-slate-400 hover:text-slate-600 focus:outline-none focus-visible:text-brand-600">
                                <!-- eye (visible) -->
                                <svg id="iconEye" class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" aria-hidden="true">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                                </svg>
                                <!-- eye-off (hidden by default) -->
                                <svg id="iconEyeOff" class="hidden h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" aria-hidden="true">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21"/>
                                </svg>
                            </button>
                        </div>
                    </div>

                    <!-- Remember me -->
                    <label class="flex items-center gap-2.5 text-sm text-slate-600 cursor-pointer select-none">
                        <input type="checkbox" name="remember" class="h-4 w-4 rounded border-slate-300 text-brand-600 focus:ring-brand-500">
                        Keep me signed in on this device
                    </label>

                    <!-- Submit -->
                    <button type="submit"
                            class="w-full rounded-xl bg-brand-600 px-4 py-3 text-sm font-semibold text-white shadow-lg shadow-brand-600/25 transition hover:bg-brand-700 focus:outline-none focus-visible:ring-2 focus-visible:ring-brand-500 focus-visible:ring-offset-2">
                        Sign in
                    </button>
                </form>

                <!-- Footer -->
                <div class="mt-8 border-t border-slate-100 pt-6 text-center text-sm text-slate-500">
                    <p>No account yet? </p>
                    <p class="mt-3 text-xs text-slate-400">Developed by <span class="font-semibold text-slate-600">Ait Youss Oussama</span></p>
                </div>
            </div>
        </section>
    </div>
</main>

<script>
    (function () {
        var input = document.getElementById('password');
        var btn = document.getElementById('togglePassword');
        var eye = document.getElementById('iconEye');
        var eyeOff = document.getElementById('iconEyeOff');

        btn.addEventListener('click', function () {
            var show = input.type === 'password';
            input.type = show ? 'text' : 'password';
            eye.classList.toggle('hidden', show);
            eyeOff.classList.toggle('hidden', !show);
            btn.setAttribute('aria-pressed', String(show));
            btn.setAttribute('aria-label', show ? 'Hide password' : 'Show password');
        });
    })();
</script>
</body>
</html>
