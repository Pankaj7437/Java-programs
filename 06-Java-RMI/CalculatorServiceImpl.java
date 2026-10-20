import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

/**
 * Remote Implementation of the CalculatorService.
 * Extends UnicastRemoteObject to enable point-to-point communication
 * via dynamic TCP socket connections.
 */
public class CalculatorServiceImpl extends UnicastRemoteObject implements CalculatorService {

    public CalculatorServiceImpl() throws RemoteException {
        super();
    }

    @Override
    public int add(int a, int b) throws RemoteException {
        System.out.println("[RMI SERVER] Executing add(" + a + ", " + b + ")");
        return a + b;
    }

    @Override
    public int subtract(int a, int b) throws RemoteException {
        System.out.println("[RMI SERVER] Executing subtract(" + a + ", " + b + ")");
        return a - b;
    }

    @Override
    public int multiply(int a, int b) throws RemoteException {
        System.out.println("[RMI SERVER] Executing multiply(" + a + ", " + b + ")");
        return a * b;
    }

    @Override
    public double divide(int a, int b) throws RemoteException {
        System.out.println("[RMI SERVER] Executing divide(" + a + ", " + b + ")");
        if (b == 0) {
            throw new ArithmeticException("Division by zero in RMI remote invocation.");
        }
        return (double) a / b;
    }
}
