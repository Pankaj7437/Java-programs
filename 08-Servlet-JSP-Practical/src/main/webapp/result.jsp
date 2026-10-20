<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Evaluation - JSP Result</title>
    <style>
        :root {
            --bg: #0f172a;
            --card-bg: #1e293b;
            --text: #f8fafc;
            --text-muted: #94a3b8;
            --border: #334155;
            --success: #10b981;
            --primary: #3b82f6;
        }
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; }
        body { background: var(--bg); color: var(--text); padding: 2.5rem; display: flex; justify-content: center; align-items: center; min-height: 100vh; }
        .card { background: var(--card-bg); border: 1px solid var(--border); border-radius: 12px; max-width: 600px; width: 100%; padding: 2rem; box-shadow: 0 10px 25px -5px rgba(0,0,0,0.4); text-align: center; }
        .badge { display: inline-block; background: #065f46; color: #34d399; padding: 0.35rem 0.85rem; border-radius: 999px; font-size: 0.85rem; font-weight: bold; margin-bottom: 1rem; }
        h1 { font-size: 1.8rem; color: #60a5fa; margin-bottom: 0.5rem; }
        p.subtitle { color: var(--text-muted); font-size: 0.95rem; margin-bottom: 1.5rem; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 1.5rem; text-align: left; }
        th, td { padding: 0.75rem 1rem; border-bottom: 1px solid var(--border); }
        th { color: var(--text-muted); font-weight: 500; font-size: 0.9rem; width: 40%; }
        td { color: var(--text); font-weight: 600; font-size: 0.95rem; }
        .highlight { color: #38bdf8; }
        .grade-badge { display: inline-block; background: #1e3a8a; color: #93c5fd; padding: 0.25rem 0.6rem; border-radius: 6px; font-size: 0.85rem; }
        a.btn { display: inline-block; padding: 0.7rem 1.5rem; background: var(--primary); color: #fff; text-decoration: none; border-radius: 6px; font-weight: 600; transition: background 0.2s; }
        a.btn:hover { background: #2563eb; }
    </style>
</head>
<body>
    <div class="card">
        <span class="badge">REGISTRATION PROCESSED</span>
        <h1>Registration Result</h1>
        <p class="subtitle">Data extracted via Controller Servlet &amp; dynamically rendered via JSP Expression Language (EL)</p>

        <table>
            <tr>
                <th>Student Name</th>
                <td class="highlight">${name}</td>
            </tr>
            <tr>
                <th>Roll Number</th>
                <td>${roll}</td>
            </tr>
            <tr>
                <th>Email Address</th>
                <td>${email}</td>
            </tr>
            <tr>
                <th>Course / Branch</th>
                <td>${course}</td>
            </tr>
            <tr>
                <th>Age</th>
                <td>${age} Years</td>
            </tr>
            <tr>
                <th>Academic Score</th>
                <td>${marks}%</td>
            </tr>
            <tr>
                <th>Computed Evaluation</th>
                <td><span class="grade-badge">${grade}</span></td>
            </tr>
        </table>

        <a class="btn" href="student.jsp">&larr; Register Another Student</a>
    </div>
</body>
</html>
