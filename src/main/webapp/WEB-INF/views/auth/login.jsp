<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Connexion</title>
    <style>
        body { font-family: sans-serif; background:#f4f6f8; display:flex;
               justify-content:center; align-items:center; height:100vh; margin:0; }
        .card { background:#fff; padding:2rem; border-radius:8px; width:320px;
                box-shadow:0 2px 10px rgba(0,0,0,.1); }
        label { display:block; margin-top:1rem; font-size:.9rem; }
        input { width:100%; padding:.6rem; margin-top:.3rem; box-sizing:border-box; }
        button { width:100%; margin-top:1.5rem; padding:.7rem; border:0;
                 background:#0d6efd; color:#fff; border-radius:4px; cursor:pointer; }
        .alert { background:#fdecea; color:#b71c1c; border:1px solid #f5c2c0;
                 padding:.7rem; border-radius:4px; margin-bottom:1rem; font-size:.9rem; }
    </style>
</head>
<body>
<div class="card">
    <h2>Connexion</h2>

    <c:if test="${not empty errorMessage}">
        <div class="alert"><c:out value="${errorMessage}"/></div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/login">
        <label for="email">Email</label>
        <input type="email" id="email" name="email"
               value="<c:out value='${enteredEmail}'/>" required>

        <label for="password">Mot de passe</label>
        <input type="password" id="password" name="password" required>

        <button type="submit">Se connecter</button>
    </form>
</div>
</body>
</html>