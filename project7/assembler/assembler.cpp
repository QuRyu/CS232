/**
 * Qingbo Liu
 * A simple machine code translator
 */

#include <map>
#include <string>
#include <fstream>
#include <iostream>
#include <sstream>

using namespace std;

map<string, int> tokens = {{"Load", 0000}, {"Store", 0001}, 
    {"Jump", 0010}, {"Branch", 001100}, {"Call", 001101}, 
    {"Return", 001110}, {"Exit", 001111}, {"Push", 0100}, 
    {"Pop", 0101}, {"Output", 0110}, {"Input", 0111}, 
    {"Add", 1000}, {"Subtract", 1001}, {"And", 1010}, 
    {"Or", 1011}, {"ExOr", 1100}, {"Shift", 1101}, 
    {"Rotate", 1110}, {"Move", 1111}, 
    {"RA", 000}, {"RB", 001}, {"RC", 010}, {"RD", 011},
    {"RE", 100}, {"SP", 101}, {"PC", 110}, {"CR", 111}};


int main(int argc, char **argv) {
    if (argc > 2 || argc <= 1)
        cout << "please give one argument" << endl;

    ifstream fin(argv[1]);
    ofstream fout(string(argv[1]) + "_output");
    string s, token;
    
    while (getline(fin, s)) {
        istringstream iss(s);
        stringstream oss;
        while (iss >> token) {
            if (tokens.find(token) != tokens.end()) {
                oss << tokens[token];
            }
            else 
                oss << token;
        }
        fout << oss.str() << endl;
    }

}
