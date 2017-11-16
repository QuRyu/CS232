/**
 * Qingbo Liu
 * A simple machine code translator
 */

#include <map>
#include <string>
#include <fstream>
#include <iostream>
#include <sstream>
#include <iomanip>
#include <ios>

using namespace std;

map<string, string> tokens = {{"Load", "0000"}, {"Store", "0001"}, 
    {"Jump", "0010"}, {"Branch", "001100"}, {"Call", "001101"}, 
    {"Return", "001110"}, {"Exit", "001111"}, {"Push","0100"}, 
    {"Pop", "0101"}, {"Output", "0110"}, {"Input", "0111"}, 
    {"Add", "1000"}, {"Subtract", "1001"}, {"And", "1010"}, 
    {"Or", "1011"}, {"ExOr", "1100"}, {"Shift", "1101"}, 
    {"Rotate", "1110"}, {"Move", "1111"}, 
    {"Zero", "00"}, {"Overflow", "01"}, {"Neg", "10"}, {"Carry", "11"},
    {"RA", "000"}, {"RB", "001"}, {"RC", "010"}, {"RD", "011"},
    {"RE", "100"}, {"SP", "101"}, {"PC", "110"}, {"CR", "111"}};


int main(int argc, char **argv) {
    if (argc > 2 || argc <= 1)
        cout << "please give one argument" << endl;

    ifstream fin(argv[1]);
    ofstream fout(string(argv[1]) + ".mif");
    string s, token;
    int line = 0;

    fout << "DEPTH = 256;" << endl 
         << "WIDTH = 16;" << endl 
         << "ADDRESS_RADIX = HEX;" << endl 
         << "DATA_RADIX = BIN;" << endl 
         << "CONTENT" << endl 
         << "BEGIN" << endl;
    
    while (getline(fin, s)) {
        istringstream iss(s);
        stringstream oss;
        oss << std::setw(2) << std::setfill('0') << std::hex << std::uppercase << line++;
        oss << " : ";
        while (iss >> token) {
            if (tokens.find(token) != tokens.end()) 
                oss << tokens[token];
            else 
                oss << token;
        }
        oss << ";";
        fout << oss.str() << endl;
    }
    
    if (line < 255) {
        stringstream oss;
        oss << std::setw(2) << std::hex << std::uppercase << 
            "[" << line << "..FF] : 1111111111111111;";
        fout << oss.str() << endl;
    }

    fout << "END" << endl;


}
