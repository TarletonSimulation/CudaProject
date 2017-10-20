#include <tsx/prefix.h>
#include <tsx/display.h>
#include <tsx/window.h>

int main(int argc, char ** argv){
	
	tsx::xDisplay	display;
	tsx::xwindow_attr	attr;

	if( display.connected() ){
		
		std::cout << "Connected to XServer: " << display.server_name() << std::endl;
		std::cout << "Connection ID: " << display.connection() << std::endl;
		std::cout << "Screen Name: " << display.screen_name() << std::endl;
		std::cout << "Screen Width: " << display.width() << std::endl;
		std::cout << "Screen Height: " << display.height() << std::endl;

		display.close();

		if( display.connected() ){
			std::cout << "Failed to disconnect..." << std::endl;
		}else	std::cout << "Disconnected from XServer" << std::endl;

	}else	std::cout << "Failed to connect..." << std::endl;

return	0;
}
