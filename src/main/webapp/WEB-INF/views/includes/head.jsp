<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        <c:out value="${pageTitle != null ? pageTitle : 'ClinicManager'}"/>
    </title>

    <!-- Figtree Font -->

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700&display=swap"
          rel="stylesheet">


    <!-- Tailwind CSS -->

    <script src="https://cdn.tailwindcss.com"></script>


    <!-- Tailwind Configuration -->

    <script>

        tailwind.config = {

            theme: {

                extend: {

                    fontFamily: {

                        sans: ['Figtree', 'ui-sans-serif', 'system-ui', 'sans-serif']

                    },

                    colors: {

                        brand: {

                            50: '#effaf8',
                            100: '#d3f3ee',
                            500: '#14a395',
                            600: '#0d8579',
                            700: '#0b6b62',
                            900: '#0b3b3a'

                        }

                    }

                }

            }

        };

    </script>


    <!-- Admin CSS -->

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assests/css/admin.css">

    <script src="${pageContext.request.contextPath}/assests/js/admin.js" defer></script>

</head>
