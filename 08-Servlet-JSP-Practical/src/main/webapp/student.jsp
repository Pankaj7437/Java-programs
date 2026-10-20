<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Registration - JSP Form</title>
    <style>
        :root {
            --primary: #3b82f6;
            --primary-hover: #2563eb;
            --bg: #0f172a;
            --card-bg: #1e293b;
            --text: #f8fafc;
            --text-muted: #94a3b8;
            --border: #334155;
        }
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; }
        body { background: var(--bg); color: var(--text); padding: 2.5rem; display: flex; justify-content: center; align-items: center; min-height: 100vh; }
        .card { background: var(--card-bg); border: 1px solid var(--border); border-radius: 12px; max-width: 550px; width: 100%; padding: 2rem; box-shadow: 0 10px 25px -5px rgba(0,0,0,0.4); }
        h1 { font-size: 1.6rem; color: #60a5fa; margin-bottom: 0.5rem; text-align: center; }
        p.desc { font-size: 0.9rem; color: var(--text-muted); text-align: center; margin-bottom: 1.5rem; }
        .form-group { margin-bottom: 1rem; }
        label { display: block; font-size: 0.85rem; color: var(--text-muted); margin-bottom: 0.35rem; }
        input[type="text"], input[type="email"], input[type="number"] {
            width: 100%; padding: 0.65rem 0.85rem; border-radius: 6px; border: 1px solid var(--border);
            background: #0f172a; color: var(--text); font-size: 0.95rem; outline: none; transition: border 0.2s;
        }
        input:focus { border-color: var(--primary); }
        .row { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; }
        button {
            width: 100%; padding: 0.8rem; border: none; border-radius: 6px; background: var(--primary);
            color: #fff; font-weight: 600; cursor: pointer; transition: background 0.2s; font-size: 1rem; margin-top: 0.5rem;
        }
        button:hover { background: var(--primary-hover); }
        .footer-note { text-align: center; margin-top: 1.5rem; font-size: 0.8rem; color: var(--text-muted); }
    </style>
</head>
<body>
    <div class="card">
        <h1>Student Registration Form</h1>
        <p class="desc">Experiment 08: Servlet Controller &amp; JSP View Architecture</p>

        <form action="student-process" method="POST">
            <div class="form-group">
                <label for="name">Full Name:</label>
                <input type="text" id="name" name="name" value="Pankaj Sharma" required>
            </div>

            <div class="row">
                <div class="form-group">
                    <label for="roll">Roll Number:</label>
                    <input type="text" id="roll" name="roll" value="21UCS101" required>
                </div>
                <div class="form-group">
                    <label for="age">Age (Years):</label>
                    <input type="number" id="age" name="age" value="21" min="15" max="99" required>
                </div>
            </div>

            <div class="form-group">
                <label for="email">Email Address:</label>
                <input type="email" id="email" name="email" value="pkscreations7437@gmail.com" required>
            </div>

            <div class="row">
                <div class="form-group">
                    <label for="course">Course / Branch:</label>
                    <input type="text" id="course" name="course" value="B.Tech Computer Science" required>
                </div>
                <div class="form-group">
                    <label for="marks">Percentage / Score (%):</label>
                    <input type="number" id="marks" name="marks" value="92.5" step="0.1" min="0" max="100" required>
                </div>
            </div>

            <button type="submit">Submit to Controller Servlet &rarr;</button>
        </form>

        <div class="footer-note">
            Submits POST request to <code>/student-process</code> (StudentServlet) &bull; Forwards to <code>result.jsp</code>
        </div>
    </div>
</body>
</html>
