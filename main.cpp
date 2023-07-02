#include <iostream>
#include <time.h>

using namespace std;

int regar(int variable1){
    int regado = rand() % 40 + 30;
    return regado;
}

int deshidratacion(int variable1, int variable2){
    int sequedad = rand() % 10 + 10;
    return sequedad;
}

int main(){

    /*Semilla generada en base al tiempo*/
    srand(time(NULL));

    int variable1;
    int variable2;

    int humedad_inicial;
    int SectoresInvernadero[5];

    /*Inicializamos el arreglo con valores iniciales de humedad aleatorios*/
    for(int i=0; i<5; i++){
        humedad_inicial = rand() % 40 + 40;
        SectoresInvernadero[i] = humedad_inicial;
    }
    cout << "Inicial" << endl;
    for(int i=0; i<5; i++){
        cout << "Sector[" << i << "] = " << SectoresInvernadero[i] << endl;
    }
    system("pause");
    cout << "Inicio" << endl;
    while(1){
        for(int i=0; i<5; i++){
            if(SectoresInvernadero[i]<=30){
                srand(time(NULL));
                SectoresInvernadero[i] += regar(variable1);
            }
            else{

            }
        }
        cout << "Regado" << endl;
        for(int i=0; i<5; i++){
            cout << "Sector[" << i << "] = " << SectoresInvernadero[i] << endl;
        }

        cout << "Secado" << endl;
        for(int i=0; i<5; i++){
            srand(time(NULL));
            SectoresInvernadero[i] -= deshidratacion(variable1,variable2);
        }
        for(int i=0; i<5; i++){
            cout << "Sector[" << i << "] = " << SectoresInvernadero[i] << endl;
        }
        system("pause");
    }

    return 0;
}