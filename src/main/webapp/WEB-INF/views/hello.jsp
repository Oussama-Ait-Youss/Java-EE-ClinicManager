<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>ClinicManager - Test Page</title>
    <style>
        body {
            font-family: system-ui, -apple-system, sans-serif;
            background-color: #0f172a;
            color: #f8fafc;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        .card {
            background-color: #1e293b;
            padding: 2rem 3rem;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5);
            border: 1px solid #334155;
            text-align: center;
        }
        h1 { color: #38bdf8; margin-bottom: 0.5rem; }
        p { color: #94a3b8; font-size: 1.1rem; }
        .timestamp { font-family: monospace; color: #4ade80; margin-top: 1rem; }
    </style>
</head>
<body>
    <div class="card">
        <h1>${serverMessage}</h1>
        <p>Servlet container running on Tomcat 10 with Jakarta EE specifications.</p>
        <div class="timestamp">Server Time: ${timestamp}</div>
    </div>
</body>
</html>