import java.util.Scanner;

public class kalkulacka_david_halacka {
    public static void main(String[] args) {
        Scanner Input = new Scanner(System.in);
        System.out.print("Vyber +, -, *, /\n");
        String sep = Input.nextLine();
        System.out.print("Zadej x: ");
        String x = Input.nextLine();
        System.out.print("Zadej y: ");
        String y = Input.nextLine();

        switch(sep) {
            case "+":
                System.out.print(Float.parseFloat(x.replace(",",".")) + Float.parseFloat(y.replace(",",".")));
                break;
            case "-":
                System.out.print(Float.parseFloat(x.replace(",",".")) - Float.parseFloat(y.replace(",",".")));
                break;
            case "*":
                System.out.print(Float.parseFloat(x.replace(",",".")) * Float.parseFloat(y.replace(",",".")));
                break;
            case "/":
                System.out.print(Float.parseFloat(x.replace(",",".")) / Float.parseFloat(y.replace(",",".")));
                break;
            default:
                System.out.print("debile něco si zkurvil");
                break;
        }
    }
}
