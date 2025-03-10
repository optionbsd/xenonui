#include <SDL.h>
#include <iostream>
#include <cstdlib>

int main(int argc, char* argv[]){
    if (argc<3) {
        std::cerr << "Usage: xui <resolution-width> <resolution-height>" << std::endl;
        return 1;
    }

    if(SDL_Init(SDL_INIT_VIDEO) < 0){
        std::cerr << "Unable to init SDL" << SDL_GetError() << "\n";
        return 1;
    }
    
    int width = std::atoi(argv[1]);
    int height = std::atoi(argv[2]);
    SDL_Window* window = SDL_CreateWindow("XenonUI Application",
                                        SDL_WINDOWPOS_CENTERED,
                                        SDL_WINDOWPOS_CENTERED,
                                        width,
                                        height,
                                        SDL_WINDOW_SHOWN);
    if(!window){
        std::cerr << "Unable to create window" << SDL_GetError() << "\n";
        SDL_Quit();
        return 1;
    }
    
    SDL_Renderer* renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
    if(!renderer){
        std::cerr << "Unable to create renderer" << SDL_GetError() << "\n";
        SDL_DestroyWindow(window);
        SDL_Quit();
        return 1;
    }
    
    SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
    SDL_RenderClear(renderer);
    SDL_RenderPresent(renderer);
    
    bool running = true;
    SDL_Event event;
    while(running){
        while(SDL_PollEvent(&event)){
            if(event.type == SDL_QUIT)
                running = false;
        }
        SDL_Delay(16);
    }
    
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
    return 0;
}
