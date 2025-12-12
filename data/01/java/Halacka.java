import java.util.Scanner;
public class Halacka {
    public static void main(String[] args) {
        Scanner UserInput = new Scanner(System.in);
    
        System.out.print("name ?: ");
        String name = UserInput.nextLine();

        System.out.print("age ?: ");
        String age = UserInput.nextLine();

        if (age.matches("\\d+")) {  
            int ageNumber = Integer.parseInt(age);

            if (ageNumber > 0) {
                System.out.print("Greetings your name: " + name + " and you are " + age + ".\n");
            } else {
                System.out.print("realy ?");
                return;
            }
        } else {
            System.out.print("Please enter a valid number!\n");
            return;
        }

        System.out.print("month ?: ");
        int month = UserInput.nextInt();
        String season = "";

        switch (month) {
            case 12,1,2 -> season = "zima";
            case 3,4,5 -> season = "jaro";
            case 6,7,8 -> season = "leto";
            case 9,10,11 -> season = "podzim";
            default -> {
                System.out.print("I don't know this month");
                return;
            }
        }
        System.out.print(season);
    }
}
