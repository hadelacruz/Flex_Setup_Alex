# Flex Docker Environment

Docker environment for [flex](https://github.com/westes/flex) (Fast Lexical Analyzer) built from source.

## Getting Started

### 1. Build and start the container

```bash
docker compose up -d --build
```

### 2. Enter the container

```bash
docker compose exec flex bash
```

### 3. Run the example

```bash
cd /workspace/examples
flex example.l
gcc lex.yy.c -o scanner
echo "Hello World from flex!" | ./scanner
```

Output:

```
Lines: 1, Words: 4, Characters: 23
```

### 4. Stop the container

```bash
docker compose down
```

Inside the container, navigate to your folder:

```bash
cd /workspace/examples/tu-carpeta
flex tu-archivo.l
gcc lex.yy.c -o scanner
./scanner < input.txt
```

## Useful flex Commands

| Command                   | Description                                 |
| ------------------------- | ------------------------------------------- |
| `flex file.l`             | Generate lex.yy.c                           |
| `flex -d file.l`          | Enable debug mode (prints each token match) |
| `flex -v file.l`          | Verbose output (shows DFA stats)            |
| `flex -o output.c file.l` | Custom output filename                      |

## File Structure

```
flex-docker/
├── Dockerfile
├── docker-compose.yml
├── README.md
├── .gitignore
└── workspace/
    └── examples/
        └── example.l
```

# Python Function Scanner

A Flex-based lexical analyzer for scanning Python function syntax.

### python.l

The Flex specification file consists of three sections:

**Section 1: Declarations** (between `%{` and `%}`)

-   C includes and global variables
-   Example: `int codeLine = 1;`

**Section 2: Rules** (between `%%` markers)

-   Pattern-action pairs
-   Example: `"def" { print_token("DEF", yytext); }`

**Section 3: User Code** (after second `%%`)

-   Helper functions
-   `yywrap()` function (required)
-   `main()` function

## How to Build

```bash
# Generate C code from Flex specification
flex python.l

# Compile the generated code
gcc lex.yy.c -o scanner -lfl

# Run the scanner
./scanner test.py
```

## Input

Text file containing Python code:

```python
def add(x, y):
    return x + y
```

## Output

```
Token(DEF, 'def', line=1, pos=1)
Token(IDENTIFIER, 'add', line=1, pos=5)
Token(LPAREN, '(', line=1, pos=8)
...
```

## Key Variables

-   `yytext` - Matched string
-   `yyleng` - Length of matched string
-   `codeLine` - Current line number
-   `position` - Current character position

## Notes

-   Generated files (`lex.yy.c`, `scanner`) are excluded from git
-   Only commit your `.l` source files
-   The container includes `gcc` for compiling the generated C code

---

# Ejercicio 2: Analizador Léxico Completo

Implementación completa de un analizador léxico que reconoce:

## Características Implementadas

### 1. **Identificadores Java**
- Comienzan con letra (a-zA-Z) o guion bajo (_)
- Seguidos de letras, dígitos o guiones bajos
- Ejemplos: `variable1`, `_identifier`, `camelCase`

### 2. **Literales Numéricos**
- **Enteros**: `42`, `123`
- **Flotantes**: `3.14`, `99.99`
- **Notación científica**: `1e5`, `2.3E-10`, `6.02e23`
- **Hexadecimales**: `0xFF`, `0xABCD`, `0X1234`

### 3. **Operadores**
- **Aritméticos**: `+`, `-`, `*`, `/`
- **Relacionales**: `==`, `!=`, `<`, `>`, `<=`, `>=`
- **Lógicos**: `&&`, `||`, `!`

### 4. **Comentarios**
- **Línea**: `// comentario hasta final de línea`
- **Multilínea**: `/* comentario que puede abarcar múltiples líneas */`

### 5. **Cadenas Literales**
- Entre comillas dobles: `"texto"`
- Secuencias de escape: `\n`, `\t`, `\"`, `\\`
- Ejemplo: `"Mensaje:\n\tHola \"Mundo\""`

## Cómo Usar

### 1. Compilar el analizador
```bash
# Dentro del contenedor Docker
cd /workspace/examples
flex java_lexer.l
gcc lex.yy.c -o java_lexer
```

### 2. Probar con diferentes archivos
```bash
# Prueba específica de identificadores
./java_lexer test_identifiers.txt

# Prueba de números
./java_lexer test_numbers.txt

# Prueba de cadenas
./java_lexer test_strings.txt

# Prueba de operadores
./java_lexer test_operators.txt

# Prueba con C# (otro lenguaje)
./java_lexer test_csharp.cs
```


### 3. Entrada desde teclado
```bash
./java_lexer
# Escribe código y presiona Ctrl+D para terminar
```

## Archivos de Prueba Incluidos

- `test_identifiers.txt` - Casos específicos de identificadores Java
- `test_numbers.txt` - Diferentes tipos de literales numéricos  
- `test_strings.txt` - Cadenas con secuencias de escape
- `test_operators.txt` - Operadores aritméticos, relacionales y lógicos
- `test_csharp.cs` - Código en C# para probar otros lenguajes
- `test_csharp.cs` - Código en C# para probar otros lenguajes

