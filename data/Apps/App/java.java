import java.util.Scanner;
import java.util.Arrays;

public class Main { 
    public static void main(String[] args) {
        //1 - 10 missing 7
//        for (int i = 1; i < 11; i++) {
//            if (i != 7) {
//                System.out.print(i + "\n");
//            } else {
//                System.out.print("\n");
//            }
//        }
        Scanner scIn = new Scanner(System.in);

        Integer[] arr = {1, 2, 3};

        while(true) {
            System.out.print("num 1 - 3\n>>");
            int num = scIn.nextInt();
            if (Arrays.asList(arr).contains(num)) {
                System.out.print("done\n");
                break;
            }
        }
    }
}

