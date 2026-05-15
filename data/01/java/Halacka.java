import java.util.Scanner;
import java.util.Random;

public class Main {
    public static void main(String[] args) {
        int[] num = new int[10];
        Random rand = new Random();
        
        System.out.printf("1.\n\n");
        for (int i = 0; i < num.length; i++) {
            num[i] = rand.nextInt(100);
        }

        for (int i = 0; i < num.length; i++) {
            System.out.printf("%d\n", num[i]);
        }
        
        System.out.printf("\n2.\n\n");
        int tmp = 0;
        for (int i = 0; i < num.length; i++) {
        	tmp += num[i];
            if(i == num.length - 1) {
            	System.out.printf("%d\n",tmp);
            }
        }
        
        System.out.printf("\n3.\n\n");
        System.out.printf("%f\n", (float) tmp/num.length);
        
        System.out.printf("\n4.\n\n");
        int rantmp = rand.nextInt(num.length);
        int find = num[rantmp];
        for (int i = 0; i < num.length; i++) {
            if (num[i] == find) {
            	System.out.printf("%d : %d\nindex %d", num[i], find, i);
                break;
            }
        }
    }
}
