# Tic-tac-toe
[Tic-tac-toe](https://en.wikipedia.org/wiki/Tic-tac-toe) implemented in Ada and SDL2.

## Building on OSX Sonoma with homebrew installed SDL2
- `alr build`
  - Manually fix SDL ada following [this](https://stackoverflow.com/questions/78363274/cannot-build-sdl-ada-bindings-on-osx-sonoma-because-of-error-missing-binary-ope);
- `brew list sdl2 sdl2_ttf sdl2_mixer sdl2_image`
  - Gather the location of the `lib` and run the command (I am not sure why brew does not install libraries in lib)
- `/usr/local/Cellar/sdl2/2.30.2/bin/sdl2-config -cflags`
  - Obtain the C flags (you can ignore the -I part)
- `alr build -- -largs "-D_THREAD_SAFE" "-L/usr/local/Cellar/sdl2_ttf/2.22.0/lib/" -lSDL2 "-L/usr/local/Cellar/sdl2_ttf/2.22.0/lib/" -lSDL2_ttf "-L/usr/local/Cellar/sdl2_mixer/2.8.0/lib/" -lSDL2_mixer "-L/usr/local/Cellar/sdl2_image/2.8.2_1/lib/" -lSDL2_image`

# References and credits
## Bebas Neue Font
- [Google Fonts](https://fonts.google.com/specimen/Bebas+Neue/about)
- [Git Hub](https://github.com/dharmatype/Bebas-Neue)

# Screenshots

<img width="412" alt="image" src="https://github.com/sanelli/tic-tac-toe/assets/2866041/cd2b1153-d15b-4500-8834-063844aa0513">
