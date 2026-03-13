import java.util.Scanner;

public class Halacka {
    public static void main(String[] args) {
        Scanner scIn = new Scanner(System.in);
        String[] name = new String[5];
        
        for (int i = 0; i < name.length; i++) {
            System.out.print(i+1 + "/" + name.length + " name>> ");
            name[i] = scIn.nextLine();
        }

        for (String s:name) {
            if (s.charAt(0) == 'P') {
                System.out.print(s + "\n");
            }
        }
    }
}
