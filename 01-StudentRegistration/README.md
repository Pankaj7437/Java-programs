# Experiment 01: Interactive Student Registration GUI Form

## 🎯 Aim & Objective
To design, develop, and test an interactive desktop Graphical User Interface (GUI) application for a **Student Registration Form** using Java Swing and Abstract Window Toolkit (AWT) event-handling mechanisms.

---

## 🛠️ Technology Stack
- **Language:** Java (JDK 17 or higher)
- **GUI Framework:** Java Swing (`javax.swing.*`)
- **Event Handling:** Java AWT Events (`java.awt.event.*`)
- **Execution Target:** Cross-platform Desktop (Windows, macOS, Linux)

---

## 📂 Directory Structure
```
01-StudentRegistration/
├── StudentRegistration.java   # Main Swing GUI class with ActionListener implementation
└── README.md                  # Comprehensive documentation and run guide
```

---

## 💡 Architecture & Key Concepts

### 1. Swing Component Hierarchy
The application extends `javax.swing.JFrame` and acts as the top-level window container:
- **`JFrame`**: Main window frame configured with title, dimensions (`400x400`), and `EXIT_ON_CLOSE`.
- **`JLabel`**: Descriptive labels for form input fields (Name, Roll Number, Gender, Branch).
- **`JTextField`**: Single-line text input fields for student name, roll number, and branch.
- **`JRadioButton` & `ButtonGroup`**: Mutually exclusive radio buttons for selecting gender (`Male` or `Female`).
- **`JCheckBox`**: Terms and conditions confirmation checkbox.
- **`JButton`**: Action buttons for **Submit** and **Reset**.
- **`JOptionPane`**: Modal dialog boxes for validation warnings and registration summary confirmation.

### 2. Layout Strategy
- Absolute Positioning (`setLayout(null)`) is utilized for explicit coordinate-based placement using `setBounds(x, y, width, height)`.

### 3. Event-Driven Programming
- Implements `ActionListener` interface.
- Overrides `actionPerformed(ActionEvent e)` to intercept user interactions from both the **Submit** and **Reset** buttons.
- Form validation checks for:
  - Empty student name (`JOptionPane.showMessageDialog` error)
  - Empty roll number
  - Gender selection state
  - Empty branch field
  - Acceptance of terms & conditions

---

## 🚀 How to Compile & Run

### Prerequisites
Make sure JDK is installed and configured in your environment:
```bash
java -version
javac -version
```

### Windows (PowerShell / Command Prompt)
```powershell
# Navigate into the experiment folder
cd 01-StudentRegistration

# Compile the source code
javac StudentRegistration.java

# Launch the GUI application
java StudentRegistration
```

### Linux / macOS (Terminal)
```bash
cd 01-StudentRegistration
javac StudentRegistration.java
java StudentRegistration
```

---

## 📋 Sample Run & Verification
1. **Launch Application:** A desktop window titled `Student Registration Form` appears with empty fields.
2. **Validation Test:** Click **Submit** without entering data. A dialog prompts: `"Please enter student name"`.
3. **Valid Submission:**
   - Enter `Name: Pankaj Sharma`
   - Enter `Roll Number: 101`
   - Select `Gender: Male`
   - Enter `Branch: Computer Science & Engineering`
   - Check `[x] I agree to terms and conditions`
   - Click **Submit**
   - A success message dialog appears showing the registered student summary.
4. **Reset Test:** Click **Reset** to clear all input fields, radio selections, and checkboxes back to initial state.

---

## 📚 Viva Questions & Conceptual Insights
1. **Why does Java Swing prefer lightweight components over AWT heavyweight components?**  
   Swing components are written entirely in Java and rendered by Java 2D graphics without relying on native OS peer widgets, providing consistent cross-platform look-and-feel.
2. **What is the purpose of `ButtonGroup` in Swing?**  
   `ButtonGroup` creates a logical relationship among radio buttons so that selecting one button automatically deselects all others in the group.
3. **What is the difference between `FlowLayout`, `BorderLayout`, and `null` layout?**  
   `FlowLayout` arranges components in a line; `BorderLayout` divides space into 5 regions (North, South, East, West, Center); `null` layout allows absolute coordinate positioning via `setBounds()`.

---

## 👤 Author
- **Developer:** Pankaj Sharma
- **Repository:** [Java-programs](https://github.com/Pankaj7437/Java-programs)
