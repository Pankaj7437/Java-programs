import java.rmi.Remote;
import java.rmi.RemoteException;

/**
 * Remote Interface for the Distributed Calculator Service.
 * Defines the contract of callable methods across JVM boundaries.
 * Must extend java.rmi.Remote and all methods must throw RemoteException.
 */
public interface CalculatorService extends Remote {

    int add(int a, int b) throws RemoteException;

    int subtract(int a, int b) throws RemoteException;

    int multiply(int a, int b) throws RemoteException;

    double divide(int a, int b) throws RemoteException;
}
