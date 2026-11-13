# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener el proyecto completo y arrancable. Guarda los archivos que te devuelva en la
carpeta del repo, respetando exactamente las rutas.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `app/src/repositories/orderRepository.ts` — La fase "Configuración inicial y creación de la tabla DynamoDB" se implementa aqui: este archivo es el ejercicio.
- `app/src/controllers/orderController.ts` — La fase "Implementación de la API REST para operaciones CRUD" se implementa aqui: este archivo es el ejercicio.

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `app` | `app/` | practice, chapter | server | Node | Express, DynamoDB |
| `infra` | `infra/` | support | infra | Terraform (AWS) | Terraform |
| `infra-local` | (raiz) | support | infra | Compose local | DynamoDB |

## Orden de arranque

1. `docker compose up -d` (en la raiz) — levanta la infraestructura local.
2. `cd infra && terraform init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/dynamodb init -backend=false && terraform validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/dynamodb validate` — componente `infra` (support).
3. `cd app && npm install --no-audit --no-fund && npm run build` — componente `app` (practice, chapter).

### Contratos entre componentes

- `app` expone http (api: http://localhost:3000):
  - `POST /orders`
  - `GET /orders/:id`
  - `PUT /orders/:id`
  - `DELETE /orders/:id`

## Como saber que terminaste

```bash
(cd app && npm install --no-audit --no-fund && npm run build) && (cd infra && terraform init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/dynamodb init -backend=false && terraform validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/dynamodb validate) && docker compose config -q
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Backend, Especialidad Desarrollador, Tecnología Node, Advanced L2

### Brecha de conocimiento
CRUD de ordenes en DynamoDB expuesto por una API REST, Implementa operaciones CRUD de ordenes sobre una tabla DynamoDB expuestas por una API REST

### Misión / candidato
Persistir y consultar ordenes

### Reto
- Tema: CRUD de ordenes sobre DynamoDB
- Seniority: advanced-l2
- Tipo: practical
- Título: Implementación de CRUD de órdenes en DynamoDB
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Configuración inicial y creación de la tabla DynamoDB — objetivo: Configurar el entorno de desarrollo y crear la tabla DynamoDB para almacenar órdenes. — entregable (NO resolver): Tabla DynamoDB creada y configurada con las columnas necesarias.
- Fase 2: Implementación de la API REST para operaciones CRUD — objetivo: Implementar las operaciones CRUD (crear, leer, actualizar, eliminar) de órdenes en la API REST. — entregable (NO resolver): API REST implementada con operaciones CRUD de órdenes, incluyendo manejo de errores y validaciones.
- Fase 3: Pruebas y optimización de la API REST — objetivo: Realizar pruebas unitarias y de integración de la API REST y optimizar el rendimiento de las operaciones CRUD. — entregable (NO resolver): API REST con pruebas unitarias y de integración, y rendimiento optimizado para las operaciones CRUD.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (entrega de archivos).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Entrega de archivos
Entregá cada archivo con su ruta completa, respetando exactamente la estructura de rutas
indicada por los marcadores: un bloque por archivo, precedido por su ruta. No generes ZIPs
ni archivos adjuntos.
La entrega debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: Entregá los archivos completos al finalizar. No preguntes si el usuario
quiere recibirlos. Simplemente entregalos; No debes desplegar en el chat el resumen de lo que arreglaste, solo entregá los archivos.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del último archivo entregado
No preguntes si el usuario quiere los archivos: simplemente entregalos siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: app/package.json ===
{
  "name": "reto-express",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "build": "tsc -p tsconfig.json",
    "test": "jest"
  },
  "dependencies": {
    "@types/jest": "30.0.0",
    "@types/supertest": "7.2.1",
    "@types/uuid": "11.0.0",
    "aws-sdk": "2.1693.0",
    "class-transformer": "0.5.1",
    "class-validator": "0.15.1",
    "express": "4.22.3",
    "jest": "30.5.2",
    "reflect-metadata": "0.2.2",
    "ts-jest": "29.4.15",
    "uuid": "14.0.3"
  },
  "devDependencies": {
    "@types/express": "4.17.25",
    "@types/node": "22.20.5",
    "typescript": "5.7.3"
  },
  "jest": {
    "preset": "ts-jest",
    "testEnvironment": "node"
  }
}

// === ARCHIVO: app/tsconfig.json ===
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "commonjs",
    "moduleResolution": "node",
    "outDir": "dist",
    "strict": true,
    "strictPropertyInitialization": false,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "resolveJsonModule": true,
    "forceConsistentCasingInFileNames": true,
    "experimentalDecorators": true,
    "emitDecoratorMetadata": true,
    "types": [
      "node"
    ]
  },
  "include": [
    "src"
  ],
  "exclude": [
    "node_modules",
    "dist",
    "_pendiente",
    "tests",
    "test",
    "src/**/*.test.ts",
    "src/**/*.spec.ts"
  ]
}

// === ARCHIVO: app/src/models/order.ts ===
import { v4 as uuidv4 } from 'uuid';

export interface Product {
    productId: string;
    quantity: number;
    price: number;
}

export class Order {
    id: string;
    createdAt: string;
    status: string;
    products: Product[];

    constructor(products: Product[], status: string = 'pending') {
        if (!products || products.length === 0) {
            throw new Error('Order must have at least one product');
        }

        this.id = uuidv4();
        this.createdAt = new Date().toISOString();
        this.status = status;
        this.products = products;
    }

    updateStatus(newStatus: string): void {
        const validStatuses = ['pending', 'processing', 'shipped', 'delivered', 'cancelled'];
        if (!validStatuses.includes(newStatus)) {
            throw new Error(`Invalid status: ${newStatus}`);
        }
        this.status = newStatus;
    }

    updateProducts(newProducts: Product[]): void {
        if (!newProducts || newProducts.length === 0) {
            throw new Error('Order must have at least one product');
        }
        this.products = newProducts;
    }

    calculateTotal(): number {
        return this.products.reduce((total, product) => {
            return total + (product.price * product.quantity);
        }, 0);
    }
}

// === ARCHIVO: app/src/dtos/orderDTO.ts ===
import { IsArray, IsNumber, IsOptional, IsString, ValidateNested } from 'class-validator';
import { Type } from 'class-transformer';

export class ProductDTO {
    @IsString()
    productId: string;

    @IsNumber()
    quantity: number;

    @IsNumber()
    price: number;
}

export class CreateOrderDTO {
    @IsArray()
    @ValidateNested({ each: true })
    @Type(() => ProductDTO)
    products: ProductDTO[];

    @IsOptional()
    @IsString()
    status?: string;
}

export class UpdateOrderDTO {
    @IsOptional()
    @IsString()
    status?: string;

    @IsOptional()
    @IsArray()
    @ValidateNested({ each: true })
    @Type(() => ProductDTO)
    products?: ProductDTO[];
}

export class OrderResponseDTO {
    @IsString()
    id: string;

    @IsString()
    createdAt: string;

    @IsString()
    status: string;

    @IsArray()
    @ValidateNested({ each: true })
    @Type(() => ProductDTO)
    products: ProductDTO[];

    constructor(id: string, createdAt: string, status: string, products: ProductDTO[]) {
        this.id = id;
        this.createdAt = createdAt;
        this.status = status;
        this.products = products;
    }
}

export function toOrderResponseDTO(order: any): OrderResponseDTO {
    return new OrderResponseDTO(
        order.id,
        order.createdAt,
        order.status,
        order.products.map((p: any) => ({
            productId: p.productId,
            quantity: p.quantity,
            price: p.price
        }))
    );
}

// === ARCHIVO: app/src/services/orderService.ts ===
import { Order } from '../models/order';
import { OrderRepository } from '../repositories/orderRepository';
import { CreateOrderDTO, UpdateOrderDTO, OrderResponseDTO, toOrderResponseDTO } from '../dtos/orderDTO';
import { OrderNotFoundError } from '../utils/errorHandler';

export class OrderService {
    constructor(private orderRepository: OrderRepository) {}

    async createOrder(createOrderDTO: CreateOrderDTO): Promise<OrderResponseDTO> {
        try {
            const order = new Order(createOrderDTO.products, createOrderDTO.status);
            const savedOrder = await this.orderRepository.create(createOrderDTO);
            return toOrderResponseDTO(savedOrder);
        } catch (error) {
            throw new Error(`Failed to create order: ${error instanceof Error ? error.message : String(error)}`);
        }
    }

    async getOrder(id: string): Promise<OrderResponseDTO> {
        const order = await this.orderRepository.findById(id);
        if (!order) {
            throw new OrderNotFoundError(`Order with id ${id} not found`);
        }
        return toOrderResponseDTO(order);
    }

    async updateOrder(id: string, updateOrderDTO: UpdateOrderDTO): Promise<OrderResponseDTO> {
        const existingOrder = await this.orderRepository.findById(id);
        if (!existingOrder) {
            throw new OrderNotFoundError(`Order with id ${id} not found`);
        }

        try {
            if (updateOrderDTO.status) {
                existingOrder.updateStatus(updateOrderDTO.status);
            }
            if (updateOrderDTO.products) {
                existingOrder.updateProducts(updateOrderDTO.products);
            }
            
            const updateDTO: UpdateOrderDTO = {
                status: existingOrder.status,
                products: existingOrder.products
            };
            
            const updatedOrder = await this.orderRepository.update(id, updateDTO);
            if (!updatedOrder) {
                throw new Error('Failed to update order: repository returned null');
            }
            return toOrderResponseDTO(updatedOrder);
        } catch (error) {
            throw new Error(`Failed to update order: ${error instanceof Error ? error.message : String(error)}`);
        }
    }

    async deleteOrder(id: string): Promise<void> {
        const existingOrder = await this.orderRepository.findById(id);
        if (!existingOrder) {
            throw new OrderNotFoundError(`Order with id ${id} not found`);
        }
        await this.orderRepository.delete(id);
    }
}

// === ARCHIVO: app/src/utils/errorHandler.ts ===
export class OrderNotFoundError extends Error {
    constructor(message: string) {
        super(message);
        this.name = 'OrderNotFoundError';
    }
}

export class ValidationError extends Error {
    constructor(message: string) {
        super(message);
        this.name = 'ValidationError';
    }
}

export class DatabaseError extends Error {
    constructor(message: string) {
        super(message);
        this.name = 'DatabaseError';
    }
}

export function errorHandler(err: Error, req: any, res: any, next: any): void {
    console.error(err);

    if (err instanceof OrderNotFoundError) {
        res.status(404).json({ error: err.message });
    } else if (err instanceof ValidationError) {
        res.status(400).json({ error: err.message });
    } else if (err instanceof DatabaseError) {
        res.status(500).json({ error: 'Database operation failed' });
    } else {
        res.status(500).json({ error: 'Internal server error' });
    }
}

// === ARCHIVO: app/src/controllers/orderController.ts ===
// TODO(reto): archivo stubbeado; implementa los cuerpos.
import { Request, Response } from 'express';
import { OrderService } from '../services/orderService';
import { CreateOrderDTO, UpdateOrderDTO } from '../dtos/orderDTO';
import { OrderResponseDTO } from '../dtos/orderDTO';
import { validate } from 'class-validator';
import { plainToInstance } from 'class-transformer';

export class OrderController {
    constructor(private orderService: OrderService) {}

    async createOrder(req: Request, res: Response): Promise<void> {
      throw new Error('TODO(reto): createOrder');
    }

    async getOrder(req: Request, res: Response): Promise<void> {
      throw new Error('TODO(reto): getOrder');
    }

    async updateOrder(req: Request, res: Response): Promise<void> {
      throw new Error('TODO(reto): updateOrder');
    }

    async deleteOrder(req: Request, res: Response): Promise<void> {
      throw new Error('TODO(reto): deleteOrder');
    }
}

// === ARCHIVO: app/src/repositories/orderRepository.ts ===
import { Order } from '../models/order';
import { CreateOrderDTO, UpdateOrderDTO } from '../dtos/orderDTO';

export interface OrderRepository {
    create(order: CreateOrderDTO): Promise<Order>;
    findById(id: string): Promise<Order | null>;
    update(id: string, order: UpdateOrderDTO): Promise<Order | null>;
    delete(id: string): Promise<boolean>;
}

export class DynamoDBOrderRepository implements OrderRepository {
    async create(order: CreateOrderDTO): Promise<Order> {
        // TODO(reto): Implementar la lógica para crear una orden en DynamoDB
        throw new Error('Method not implemented.');
    }

    async findById(id: string): Promise<Order | null> {
        // TODO(reto): Implementar la lógica para buscar una orden por ID en DynamoDB
        throw new Error('Method not implemented.');
    }

    async update(id: string, order: UpdateOrderDTO): Promise<Order | null> {
        // TODO(reto): Implementar la lógica para actualizar una orden en DynamoDB
        throw new Error('Method not implemented.');
    }

    async delete(id: string): Promise<boolean> {
        // TODO(reto): Implementar la lógica para eliminar una orden en DynamoDB
        throw new Error('Method not implemented.');
    }
}

// === ARCHIVO: app/src/config/dynamodb.ts ===
import AWS from 'aws-sdk';

const isLocal = process.env.DYNAMODB_ENDPOINT !== undefined;

const dynamoDBConfig: AWS.DynamoDB.ClientConfiguration = {
  region: process.env.AWS_REGION || 'us-east-1',
  ...(isLocal ? {
    endpoint: process.env.DYNAMODB_ENDPOINT,
    sslEnabled: false,
    accessKeyId: process.env.AWS_ACCESS_KEY_ID || 'local',
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY || 'local',
  } : {
    credentials: {
      accessKeyId: process.env.AWS_ACCESS_KEY_ID || '',
      secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY || '',
    },
  }),
};

export const dynamoDB = new AWS.DynamoDB(dynamoDBConfig);
export const dynamoDBDocument = new AWS.DynamoDB.DocumentClient(dynamoDBConfig);

export const TABLE_NAME = process.env.DYNAMODB_TABLE_NAME || 'orders';

export function getDynamoDBClient(): AWS.DynamoDB {
  return dynamoDB;
}

export function getDocumentClient(): AWS.DynamoDB.DocumentClient {
  return dynamoDBDocument;
}

export async function createTableIfNotExists(): Promise<void> {
  try {
    const result = await dynamoDB.listTables().promise();
    if (result.TableNames?.includes(TABLE_NAME)) {
      return;
    }
  } catch (error) {
    console.error('Error checking table existence:', error);
  }

  const params: AWS.DynamoDB.CreateTableInput = {
    TableName: TABLE_NAME,
    KeySchema: [
      { AttributeName: 'id', KeyType: 'HASH' },
    ],
    AttributeDefinitions: [
      { AttributeName: 'id', AttributeType: 'S' },
    ],
    BillingMode: 'PAY_PER_REQUEST',
  };

  try {
    await dynamoDB.createTable(params).promise();
    console.log(`Table ${TABLE_NAME} created successfully`);
  } catch (error: any) {
    if (error.code === 'ResourceInUseException') {
      console.log(`Table ${TABLE_NAME} already exists`);
      return;
    }
    console.error('Error creating table:', error);
    throw error;
  }
}

export function config(): void {
  if (isLocal) {
    console.log('Running in local mode with DynamoDB endpoint:', process.env.DYNAMODB_ENDPOINT);
  } else {
    console.log('Running in AWS mode with region:', process.env.AWS_REGION || 'us-east-1');
  }
}

// === ARCHIVO: app/src/main.ts ===
import 'reflect-metadata';
import { createServer } from 'http';
import { createExpressApp } from './server';
import { config } from './config/dynamodb';
import { createTableIfNotExists } from './config/dynamodb';

const PORT = process.env.PORT || 3000;

async function bootstrap(): Promise<void> {
  try {
    config();
    await createTableIfNotExists();
    
    const app = createExpressApp();
    const server = createServer(app);
    
    server.listen(PORT, () => {
      console.log(`Servidor iniciado en http://localhost:${PORT}`);
      console.log('Presiona Ctrl+C para detener el servidor');
    });
    
    server.on('error', (error: NodeJS.ErrnoException) => {
      if (error.code === 'EADDRINUSE') {
        console.error(`El puerto ${PORT} ya está en uso`);
        process.exit(1);
      }
      throw error;
    });
    
  } catch (error) {
    console.error('Error al iniciar la aplicación:', error);
    process.exit(1);
  }
}

bootstrap();

// === ARCHIVO: app/src/server.ts ===
import express, { Express, Request, Response, NextFunction } from 'express';
import { OrderController } from './controllers/orderController';
import { OrderService } from './services/orderService';
import { DynamoDBOrderRepository } from './repositories/orderRepository';
import { errorHandler } from './utils/errorHandler';

export function createExpressApp(): Express {
  const app = express();
  
  const orderRepository = new DynamoDBOrderRepository();
  const orderService = new OrderService(orderRepository);
  const orderController = new OrderController(orderService);
  
  app.use(express.json());
  app.use(express.urlencoded({ extended: true }));
  
  app.get('/health', (_req: Request, res: Response) => {
    res.status(200).json({ status: 'ok', timestamp: new Date().toISOString() });
  });
  
  app.post('/orders', (req: Request, res: Response, next: NextFunction) => {
    orderController.createOrder(req, res).catch(next);
  });
  
  app.get('/orders/:id', (req: Request, res: Response, next: NextFunction) => {
    orderController.getOrder(req, res).catch(next);
  });
  
  app.put('/orders/:id', (req: Request, res: Response, next: NextFunction) => {
    orderController.updateOrder(req, res).catch(next);
  });
  
  app.delete('/orders/:id', (req: Request, res: Response, next: NextFunction) => {
    orderController.deleteOrder(req, res).catch(next);
  });
  
  app.use(errorHandler);
  
  return app;
}

// === ARCHIVO: app/src/app.ts ===
import { createExpressApp } from './server';

export const app = createExpressApp();

// === ARCHIVO: infra/versions.tf ===
terraform {
  required_version = ">= 1.9.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.100.0"
    }
  }
}

// === ARCHIVO: infra/providers.tf ===
provider "aws" {
  region = "us-east-1"
}

// === ARCHIVO: infra/environments/dev/terraform.tfvars ===
# Variables para el entorno de desarrollo
# Configuración específica para la tabla DynamoDB de órdenes

table_name = "orders-dev"
billing_mode = "PAY_PER_REQUEST"
hash_key = "order_id"
range_key = "created_at"

# Definición de atributos de la tabla
attributes = [
  {
    name = "order_id"
    type = "S"
  },
  {
    name = "created_at"
    type = "S"
  },
  {
    name = "customer_id"
    type = "S"
  },
  {
    name = "status"
    type = "S"
  }
]

# Índices secundarios globales (GSI)
global_secondary_indexes = [
  {
    name               = "CustomerIndex"
    hash_key           = "customer_id"
    range_key          = "created_at"
    projection_type    = "INCLUDE"
    non_key_attributes = ["order_id", "status", "items"]
    read_capacity      = 0
    write_capacity     = 0
  },
  {
    name               = "StatusIndex"
    hash_key           = "status"
    range_key          = "created_at"
    projection_type    = "KEYS_ONLY"
    read_capacity      = 0
    write_capacity     = 0
  }
]

# Etiquetas para los recursos
tags = {
  Environment = "dev"
  Application = "ecommerce-orders"
  Terraform   = "true"
}

# Configuración de TTL (Time To Live)
ttl_attribute = "expiration_time"
ttl_enabled   = true

# Configuración de streams para eventos
stream_enabled   = true
stream_view_type = "NEW_AND_OLD_IMAGES"

# Configuración de cifrado
server_side_encryption_enabled = true
kms_key_arn                    = "arn:aws:kms:us-east-1:123456789012:key/abcd1234-5678-90ef-ghij-klmnopqrstuv"

# Configuración de backups
point_in_time_recovery_enabled = true

# Configuración de capacidad para pruebas de carga
replica_regions = [
  {
    region_name = "us-west-2"
  }
]

# Validaciones de esquema
schema_validation = {
  required_attributes = ["order_id", "created_at", "customer_id", "status", "items"]
  attribute_constraints = {
    order_id = {
      regex = "^ORD-[A-Za-z0-9]{8}$"
    }
    status = {
      allowed_values = ["PENDING", "PROCESSING", "SHIPPED", "DELIVERED", "CANCELLED"]
    }
  }
}

// === ARCHIVO: infra/modules/dynamodb/main.tf ===
# Módulo DynamoDB para creación de tablas de órdenes
# Este módulo crea una tabla DynamoDB con configuración flexible para diferentes entornos

resource "aws_dynamodb_table" "orders_table" {
  name           = var.table_name
  billing_mode   = var.billing_mode
  hash_key       = var.hash_key
  range_key      = var.range_key

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_indexes
    content {
      name               = global_secondary_index.value.name
      hash_key           = global_secondary_index.value.hash_key
      range_key          = global_secondary_index.value.range_key
      projection_type    = global_secondary_index.value.projection_type
      non_key_attributes = global_secondary_index.value.non_key_attributes
      read_capacity      = global_secondary_index.value.read_capacity
      write_capacity     = global_secondary_index.value.write_capacity
    }
  }

  ttl {
    attribute_name = var.ttl_attribute
    enabled        = var.ttl_enabled
  }

  stream_enabled   = var.stream_enabled
  stream_view_type = var.stream_view_type

  server_side_encryption {
    enabled     = var.server_side_encryption_enabled
    kms_key_arn = var.kms_key_arn
  }

  point_in_time_recovery {
    enabled = var.point_in_time_recovery_enabled
  }

  dynamic "replica" {
    for_each = var.replica_regions
    content {
      region_name = replica.value.region_name
    }
  }

  tags = merge(
    var.tags,
    {
      Name = var.table_name
    }
  )

  # Validación de esquema mediante AWS SDK en la aplicación
  # Las validaciones de esquema se manejan a nivel de aplicación
}

# Política para permitir acceso a la tabla desde la aplicación
resource "aws_iam_policy" "dynamodb_access_policy" {
  name        = "${var.table_name}-access-policy"
  description = "Política de acceso a la tabla DynamoDB ${var.table_name}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:BatchWriteItem",
          "dynamodb:BatchGetItem"
        ]
        Resource = aws_dynamodb_table.orders_table.arn
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:Query",
          "dynamodb:Scan"
        ]
        Resource = "${aws_dynamodb_table.orders_table.arn}/index/*"
      }
    ]
  })
}

// === ARCHIVO: infra/modules/dynamodb/variables.tf ===
# Variables de entrada para el módulo DynamoDB

variable "table_name" {
  description = "Nombre de la tabla DynamoDB"
  type        = string
  validation {
    condition     = length(var.table_name) > 3 && length(var.table_name) <= 255
    error_message = "El nombre de la tabla debe tener entre 4 y 255 caracteres."
  }
}

variable "billing_mode" {
  description = "Modo de facturación de la tabla (PROVISIONED o PAY_PER_REQUEST)"
  type        = string
  default     = "PAY_PER_REQUEST"
  validation {
    condition     = contains(["PROVISIONED", "PAY_PER_REQUEST"], var.billing_mode)
    error_message = "El modo de facturación debe ser PROVISIONED o PAY_PER_REQUEST."
  }
}

variable "hash_key" {
  description = "Clave hash (partition key) de la tabla"
  type        = string
  validation {
    condition     = length(var.hash_key) > 0
    error_message = "La clave hash no puede estar vacía."
  }
}

variable "range_key" {
  description = "Clave de rango (sort key) de la tabla"
  type        = string
  default     = null
}

variable "attributes" {
  description = "Lista de atributos de la tabla"
  type = list(object({
    name = string
    type = string
  }))
  validation {
    condition     = length(var.attributes) > 0
    error_message = "Debe proporcionar al menos un atributo para la tabla."
  }
  validation {
    condition = alltrue([
      for attr in var.attributes : contains(["S", "N", "B"], attr.type)
    ])
    error_message = "Los tipos de atributos válidos son S (string), N (number) y B (binary)."
  }
}

variable "global_secondary_indexes" {
  description = "Lista de índices secundarios globales (GSI)"
  type = list(object({
    name               = string
    hash_key           = string
    range_key          = string
    projection_type    = string
    non_key_attributes = list(string)
    read_capacity      = number
    write_capacity     = number
  }))
  default = []
  validation {
    condition = alltrue([
      for gsi in var.global_secondary_indexes : contains(["KEYS_ONLY", "INCLUDE", "ALL"], gsi.projection_type)
    ])
    error_message = "Los tipos de proyección válidos son KEYS_ONLY, INCLUDE y ALL."
  }
}

variable "ttl_attribute" {
  description = "Atributo para Time To Live (TTL)"
  type        = string
  default     = null
}

variable "ttl_enabled" {
  description = "Habilitar Time To Live (TTL)"
  type        = bool
  default     = false
}

variable "stream_enabled" {
  description = "Habilitar streams de DynamoDB"
  type        = bool
  default     = false
}

variable "stream_view_type" {
  description = "Tipo de vista del stream (KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES)"
  type        = string
  default     = null
  validation {
    condition     = var.stream_view_type == null ? true : contains(["KEYS_ONLY", "NEW_IMAGE", "OLD_IMAGE", "NEW_AND_OLD_IMAGES"], var.stream_view_type)
    error_message = "El tipo de vista del stream debe ser KEYS_ONLY, NEW_IMAGE, OLD_IMAGE o NEW_AND_OLD_IMAGES."
  }
}

variable "server_side_encryption_enabled" {
  description = "Habilitar cifrado del lado del servidor"
  type        = bool
  default     = false
}

variable "kms_key_arn" {
  description = "ARN de la clave KMS para cifrado"
  type        = string
  default     = null
}

variable "point_in_time_recovery_enabled" {
  description = "Habilitar recuperación a un punto en el tiempo"
  type        = bool
  default     = false
}

variable "replica_regions" {
  description = "Regiones para réplicas globales"
  type = list(object({
    region_name = string
  }))
  default = []
}

variable "tags" {
  description = "Etiquetas para los recursos"
  type        = map(string)
  default     = {}
}

// === ARCHIVO: infra/modules/dynamodb/outputs.tf ===
# Outputs del módulo DynamoDB

output "table_arn" {
  description = "ARN de la tabla DynamoDB"
  value       = aws_dynamodb_table.orders_table.arn
}

output "table_name" {
  description = "Nombre de la tabla DynamoDB"
  value       = aws_dynamodb_table.orders_table.name
}

output "table_id" {
  description = "ID de la tabla DynamoDB"
  value       = aws_dynamodb_table.orders_table.id
}

output "table_stream_arn" {
  description = "ARN del stream de la tabla DynamoDB"
  value       = aws_dynamodb_table.orders_table.stream_arn
}

output "table_stream_label" {
  description = "Etiqueta del stream de la tabla DynamoDB"
  value       = aws_dynamodb_table.orders_table.stream_label
}

output "access_policy_arn" {
  description = "ARN de la política de acceso a la tabla DynamoDB"
  value       = aws_iam_policy.dynamodb_access_policy.arn
}

output "global_secondary_indexes" {
  description = "Información de los índices secundarios globales"
  value = [
    for gsi in aws_dynamodb_table.orders_table.global_secondary_index :
    {
      name               = gsi.name
      arn                = "${aws_dynamodb_table.orders_table.arn}/index/${gsi.name}"
      projection_type    = gsi.projection_type
      non_key_attributes = gsi.non_key_attributes
    }
  ]
}

output "table_tags" {
  description = "Etiquetas aplicadas a la tabla DynamoDB"
  value       = aws_dynamodb_table.orders_table.tags
}

output "replica_regions" {
  description = "Regiones de réplica configuradas"
  value       = aws_dynamodb_table.orders_table.replica[*].region_name
}

// === ARCHIVO: infra/README.md ===
# Infraestructura Terraform - CRUD de Órdenes DynamoDB

Este componente contiene la definición de infraestructura como código para el sistema de gestión de órdenes sobre DynamoDB.

## Propósito

Provisiona los recursos de AWS necesarios para soportar el CRUD de órdenes en un sistema de e-commerce, incluyendo:
- Tabla DynamoDB para almacenamiento de órdenes
- Políticas IAM para acceso a la tabla
- Recursos auxiliares según necesidad del entorno

## Estructura de Directorios

```
infra/
├── environments/
│   └── dev/
│       ├── main.tf          # Configuración del entorno de desarrollo
│       ├── variables.tf     # Variables específicas del entorno
│       └── outputs.tf       # Outputs del entorno
├── modules/
│   └── dynamodb/
│       ├── main.tf          # Recurso principal de DynamoDB
│       ├── variables.tf     # Variables del módulo
│       └── outputs.tf       # Outputs del módulo
├── versions.tf              # Versiones de Terraform y providers
├── providers.tf             # Configuración de providers
└── README.md                # Este archivo
```

## Requisitos Previos

- Terraform >= 1.9.0
- AWS CLI configurado con credenciales válidas
- Permisos para crear recursos en la cuenta de AWS objetivo

## Configuración Inicial

### 1. Configurar credenciales AWS

```bash
export AWS_ACCESS_KEY_ID="tu_access_key"
export AWS_SECRET_ACCESS_KEY="tu_secret_key"
export AWS_REGION="us-east-1"
```

### 2. Inicializar Terraform

```bash
cd infra
terraform init
```

### 3. Validar la configuración

```bash
terraform validate
terraform plan
```

## Uso del Módulo DynamoDB

### Ejemplo Básico

Para crear una tabla de órdenes con la configuración por defecto:

```hcl
module "orders_table" {
  source = "../modules/dynamodb"
  
  table_name = "orders"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "order_id"
  
  attributes = [
    { name = "order_id", type = "S" },
    { name = "customer_id", type = "S" },
    { name = "status", type = "S" },
    { name = "created_at", type = "S" }
  ]
  
  tags = {
    Environment = "dev"
    Project     = "ecommerce-orders"
  }
}
```

### Ejemplo con GSI

Para crear una tabla con índices secundarios globales:

```hcl
module "orders_table_with_gsi" {
  source = "../modules/dynamodb"
  
  table_name = "orders"
  billing_mode = "PROVISIONED"
  hash_key = "order_id"
  
  attributes = [
    { name = "order_id", type = "S" },
    { name = "customer_id", type = "S" },
    { name = "status", type = "S" },
    { name = "created_at", type = "S" }
  ]
  
  global_secondary_indexes = [
    {
      name               = "customer_status_index"
      hash_key           = "customer_id"
      range_key          = "status"
      projection_type    = "ALL"
      non_key_attributes = ["order_id", "created_at", "total_amount"]
      read_capacity      = 5
      write_capacity     = 5
    }
  ]
  
  tags = {
    Environment = "dev"
    Project     = "ecommerce-orders"
  }
}
```

### Ejemplo con Cifrado y TTL

Para habilitar cifrado del lado del servidor y Time To Live:

```hcl
module "orders_table_secure" {
  source = "../modules/dynamodb"
  
  table_name = "orders"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "order_id"
  
  attributes = [
    { name = "order_id", type = "S" },
    { name = "created_at", type = "S" }
  ]
  
  # Habilitar cifrado con KMS
  server_side_encryption_enabled = true
  kms_key_arn = "arn:aws:kms:us-east-1:123456789012:key/your-key-id"
  
  # Habilitar TTL
  ttl_attribute    = "expires_at"
  ttl_enabled      = true
  
  # Habilitar streams para captura de cambios
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  
  tags = {
    Environment = "prod"
    Project     = "ecommerce-orders"
    Compliance  = "PII"
  }
}
```

## Variables del Módulo DynamoDB

| Variable | Tipo | Default | Descripción |
|----------|------|---------|-------------|
| `table_name` | string | - | Nombre de la tabla (requerido, 4-255 caracteres) |
| `billing_mode` | string | "PAY_PER_REQUEST" | Modo de facturación |
| `hash_key` | string | - | Clave hash de la tabla |
| `range_key` | string | null | Clave de rango de la tabla |
| `attributes` | list(object) | - | Lista de atributos de la tabla |
| `global_secondary_indexes` | list(object) | [] | Índices secundarios globales |
| `ttl_attribute` | string | null | Atributo para TTL |
| `ttl_enabled` | bool | false | Habilitar TTL |
| `stream_enabled` | bool | false | Habilitar streams |
| `stream_view_type` | string | null | Tipo de vista del stream |
| `server_side_encryption_enabled` | bool | false | Habilitar cifrado SSE |
| `kms_key_arn` | string | null | ARN de clave KMS |
| `point_in_time_recovery_enabled` | bool | false | Habilitar PITR |
| `replica_regions` | list(object) | [] | Regiones para réplicas globales |
| `tags` | map(string) | {} | Etiquetas para recursos |

## Outputs del Módulo

| Output | Descripción |
|--------|-------------|
| `table_arn` | ARN de la tabla DynamoDB |
| `table_name` | Nombre de la tabla |
| `table_id` | ID de la tabla |
| `table_stream_arn` | ARN del stream |
| `table_stream_label` | Etiqueta del stream |
| `access_policy_arn` | ARN de la política de acceso |
| `global_secondary_indexes` | Información de GSI |
| `table_tags` | Etiquetas aplicadas |
| `replica_regions` | Regiones de réplica |

## Aplicar Infraestructura

### Entorno de Desarrollo

```bash
cd environments/dev
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

### Destruir Recursos

```bash
terraform destroy -var-file="terraform.tfvars"
```

## Consideraciones de Seguridad

1. **Cifrado**: Habilita `server_side_encryption_enabled` para datos en reposo
2. **KMS**: Usa claves KMS gestionadas o propias según requisitos de compliance
3. **TTL**: Configura TTL para datos que expiren automáticamente
4. **Streams**: Habilita streams solo si necesitas capturar cambios para otros procesos
5. **Réplicas**: Considera réplicas globales para alta disponibilidad

## Mejores Prácticas

- Usa estado remoto (S3) para colaboración en equipo
- Implementa workspaces para separación de entornos
- Versiona tu código de infraestructura
- Documenta variables y outputs
- Usa etiquetas consistentes en todos los recursos
- Implementa pipelines de CI/CD para cambios de infraestructura

## Recursos Adicionales

- [Documentación de Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Documentación de DynamoDB](https://docs.aws.amazon.com/dynamodb/)
- [Mejores prácticas de DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/best-practices.html)

// === ARCHIVO: infra/environments/dev/main.tf ===
# Configuración principal de Terraform para el entorno de desarrollo
# Este archivo orquesta la creación de recursos AWS específicos del entorno dev

terraform {
  backend "s3" {
    bucket         = "ecommerce-terraform-state"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}

# Instanciación del módulo DynamoDB para almacenar órdenes del e-commerce
# El módulo se configura con los valores definidos en terraform.tfvars
module "dynamodb" {
  source = "../../modules/dynamodb"

  # Nombre de la tabla - consumido de dev_variables
  table_name = var.dev_variables.table_name

  # Clave de partición - consumed de dev_variables
  hash_key = var.dev_variables.hash_key

  # Clave de ordenamiento (opcional) - consumido de dev_variables
  range_key = var.dev_variables.range_key

  # Modo de facturación - consumido de dev_variables
  billing_mode = var.dev_variables.billing_mode

  # Atributos de la tabla - consumido de dev_variables
  attributes = var.dev_variables.attributes

  # Índices secundarios globales - consumido de dev_variables
  global_secondary_indexes = var.dev_variables.global_secondary_indexes

  # Configuración de TTL - consumido de dev_variables
  ttl_attribute = var.dev_variables.ttl_attribute
  ttl_enabled   = var.dev_variables.ttl_enabled

  # Configuración de streams - consumido de dev_variables
  stream_enabled   = var.dev_variables.stream_enabled
  stream_view_type = var.dev_variables.stream_view_type

  # Cifrado del lado del servidor - consumido de dev_variables
  server_side_encryption_enabled = var.dev_variables.server_side_encryption_enabled
  kms_key_arn                    = var.dev_variables.kms_key_arn

  # Recuperación a punto en el tiempo - consumido de dev_variables
  point_in_time_recovery_enabled = var.dev_variables.point_in_time_recovery_enabled

  # Réplicas globales - consumido de dev_variables
  replica_regions = var.dev_variables.replica_regions

  # Etiquetas estándar del entorno
  tags = merge(
    var.dev_variables.common_tags,
    {
      Environment = "dev"
      ManagedBy   = "terraform"
    }
  )
}

# Recurso adicional: Política de acceso específica para el entorno de desarrollo
# Esta política permite a las funciones Lambda del entorno dev acceder a la tabla
resource "aws_iam_policy" "dynamodb_dev_access" {
  name        = "${var.dev_variables.table_name}-dev-access"
  description = "Política de acceso para operaciones CRUD en entorno de desarrollo"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:DescribeTable"
        ]
        Resource = [
          module.dynamodb.table_arn,
          "${module.dynamodb.table_arn}/index/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:ListTables"
        ]
        Resource = "*"
      }
    ]
  })

  tags = merge(
    var.dev_variables.common_tags,
    {
      Environment = "dev"
      Component   = "dynamodb-access"
    }
  )
}

# Recurso adicional: Bucket S3 para logs del entorno de desarrollo
resource "aws_s3_bucket" "dev_logs" {
  bucket = "${var.dev_variables.project_name}-${var.dev_variables.environment}-logs"

  tags = merge(
    var.dev_variables.common_tags,
    {
      Environment = "dev"
      Component   = "logging"
    }
  )
}

# Configuración de versionado del bucket de logs
resource "aws_s3_bucket_versioning" "dev_logs" {
  bucket = aws_s3_bucket.dev_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Configuración de lifecycle para logs (eliminación después de 90 días en dev)
resource "aws_s3_bucket_lifecycle_configuration" "dev_logs" {
  bucket = aws_s3_bucket.dev_logs.id

  rule {
    id     = "delete-old-logs"
    status = "Enabled"

    expiration {
      days = 90
    }
  }
}

// === ARCHIVO: infra/environments/dev/variables.tf ===
# Definición de variables específicas para el entorno de desarrollo
# Estas variables permiten configurar los recursos de forma flexible

variable "dev_variables" {
  description = "Variables de configuración del entorno de desarrollo definidas en terraform.tfvars"
  type = object({
    # Configuración de la tabla DynamoDB
    table_name               = string
    hash_key                 = string
    range_key                = optional(string)
    billing_mode             = string
    attributes               = list(object({
      name = string
      type = string
    }))
    global_secondary_indexes = list(object({
      name               = string
      hash_key           = string
      range_key          = optional(string)
      projection_type    = string
      non_key_attributes = list(string)
      read_capacity      = number
      write_capacity     = number
    }))

    # Configuración de TTL
    ttl_attribute = optional(string)
    ttl_enabled   = optional(bool, false)

    # Configuración de streams
    stream_enabled   = optional(bool, false)
    stream_view_type = optional(string)

    # Configuración de cifrado
    server_side_encryption_enabled = optional(bool, false)
    kms_key_arn                    = optional(string)

    # Configuración de recuperación
    point_in_time_recovery_enabled = optional(bool, false)

    # Réplicas globales
    replica_regions = optional(list(object({
      region_name = string
    })), [])

    # Etiquetas comunes
    common_tags = map(string)

    # Metadatos del proyecto
    project_name  = string
    environment   = string
    owner_team    = optional(string, "platform-team")
    cost_center   = optional(string, "engineering")
  })

  validation {
    condition     = var.dev_variables.billing_mode != ""
    error_message = "El modo de facturación no puede estar vacío."
  }

  validation {
    condition     = length(var.dev_variables.table_name) > 0
    error_message = "El nombre de la tabla no puede estar vacío."
  }

  validation {
    condition     = length(var.dev_variables.attributes) > 0
    error_message = "Debe proporcionar al menos un atributo para la tabla."
  }
}

variable "environment" {
  description = "Nombre del entorno de despliegue"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "El entorno debe ser dev, staging o prod."
  }
}

variable "aws_region" {
  description = "Región AWS donde se desplegarán los recursos"
  type        = string
  default     = "us-east-1"
}

variable "enable_monitoring" {
  description = "Habilitar métricas y alertas de CloudWatch para el entorno"
  type        = bool
  default     = false
}

variable "retention_days" {
  description = "Días de retención de logs en S3"
  type        = number
  default     = 90
  validation {
    condition     = var.retention_days >= 7 && var.retention_days <= 365
    error_message = "La retención de logs debe estar entre 7 y 365 días."
  }
}

// === ARCHIVO: infra/environments/dev/outputs.tf ===
# Definición de outputs para el entorno de desarrollo
# Expone la información de los recursos creados para consumo externo

# Output principal: información de la tabla DynamoDB creada
output "dynamodb_table" {
  description = "Información de la tabla DynamoDB creada para el entorno de desarrollo"
  value = {
    arn      = module.dynamodb.table_arn
    name     = module.dynamodb.table_name
    id       = module.dynamodb.table_id
    stream_arn = module.dynamodb.table_stream_arn
    stream_label = module.dynamodb.table_stream_label
  }
}

# Output: nombre de la tabla DynamoDB
output "table_name" {
  description = "Nombre de la tabla DynamoDB de órdenes"
  value       = module.dynamodb.table_name
  sensitive   = false
}

# Output: ARN de la tabla DynamoDB
output "table_arn" {
  description = "ARN completo de la tabla DynamoDB"
  value       = module.dynamodb.table_arn
  sensitive   = false
}

# Output: política de acceso creada
output "dynamodb_access_policy" {
  description = "Política IAM de acceso a la tabla DynamoDB"
  value = {
    arn  = aws_iam_policy.dynamodb_dev_access.arn
    name = aws_iam_policy.dynamodb_dev_access.name
    id   = aws_iam_policy.dynamodb_dev_access.id
  }
  sensitive = false
}

# Output: bucket de logs del entorno
output "logs_bucket" {
  description = "Bucket S3 para almacenamiento de logs del entorno"
  value = {
    name                 = aws_s3_bucket.dev_logs.id
    arn                  = aws_s3_bucket.dev_logs.arn
    versioning_status    = aws_s3_bucket_versioning.dev_logs.versioning_configuration[0].status
    lifecycle_rule_id    = aws_s3_bucket_lifecycle_configuration.dev_logs.rule[0].id
    retention_days       = var.retention_days
  }
  sensitive = false
}

# Output: configuración del entorno
output "environment_config" {
  description = "Configuración general del entorno de desarrollo"
  value = {
    environment         = var.environment
    aws_region          = var.aws_region
    enable_monitoring   = var.enable_monitoring
    retention_days      = var.retention_days
    project_name        = var.dev_variables.project_name
    owner_team          = var.dev_variables.owner_team
    cost_center         = var.dev_variables.cost_center
  }
  sensitive = false
}

# Output: índices secundarios globales configurados
output "global_secondary_indexes" {
  description = "Índices secundarios globales configurados en la tabla"
  value       = module.dynamodb.global_secondary_indexes
  sensitive   = false
}

# Output: regiones de réplica (si aplica)
output "replica_regions" {
  description = "Regiones de réplica configuradas para la tabla"
  value       = module.dynamodb.replica_regions
  sensitive   = false
}

# Output: etiquetas aplicadas a los recursos
output "resource_tags" {
  description = "Etiquetas aplicadas a los recursos del entorno"
  value       = module.dynamodb.table_tags
  sensitive   = false
}

# Output: URL del bucket de logs (para configuración de aplicaciones)
output "logs_bucket_url" {
  description = "URL del bucket S3 de logs para configuración en aplicaciones"
  value       = "s3://${aws_s3_bucket.dev_logs.id}"
  sensitive   = false
}

# Output: endpoint de DynamoDB (útil para desarrollo local con LocalStack)
output "dynamodb_endpoint" {
  description = "Endpoint de DynamoDB para el entorno (usar en desarrollo local)"
  value       = "https://dynamodb.${var.aws_region}.amazonaws.com"
  sensitive   = false
}

// === ARCHIVO: docker-compose.yml ===
# Infraestructura local del reto. SOLO desarrollo: credenciales de ejemplo (local-dev-only), puertos en loopback.
# Levantar: docker compose up -d --wait
name: infra-local
services:
  dynamodb-local:
    image: "amazon/dynamodb-local:2.5.2"
    command: ["-jar","DynamoDBLocal.jar","-sharedDb","-inMemory"]
    ports:
      - "127.0.0.1:8000:8000"
    healthcheck:
      test: ["CMD-SHELL","bash -c ':> /dev/tcp/127.0.0.1/8000' || exit 1"]
      interval: 10s
      timeout: 5s
      retries: 10
      start_period: 5s


// === ARCHIVO: infra-local/README.md ===
# Infraestructura local

Servicios de soporte para el reto, definidos en `docker-compose.yml` (raiz del repo).

```bash
docker compose up -d --wait
```

| Servicio | Imagen | Puertos (host) |
|---|---|---|
| DynamoDB Local | `amazon/dynamodb-local:2.5.2` | 8000 |

Credenciales: solo de desarrollo local (`local-dev-only`, `local`). No son secretos ni deben reutilizarse.
Los scripts de `infra-local/` (tablas, topics) se ejecutan con el compose en estado healthy.

Tablas de DynamoDB: `orders` (pk `id`).


// === ARCHIVO: infra-local/dynamodb/create-tables.sh ===
#!/usr/bin/env bash
# Crea las tablas en DynamoDB Local (idempotente). Credenciales dummy: DynamoDB Local no valida firmas.
set -euo pipefail

export AWS_ACCESS_KEY_ID=local
export AWS_SECRET_ACCESS_KEY=local
export AWS_REGION=us-east-1
ENDPOINT="${DYNAMODB_ENDPOINT:-http://localhost:8000}"

create_table() {
  local name="$1" pk="$2" sk="${3:-}"
  if aws dynamodb describe-table --table-name "$name" --endpoint-url "$ENDPOINT" >/dev/null 2>&1; then
    echo "Tabla $name ya existe"
    return
  fi
  local attrs="AttributeName=$pk,AttributeType=S"
  local keys="AttributeName=$pk,KeyType=HASH"
  if [ -n "$sk" ]; then
    attrs="$attrs AttributeName=$sk,AttributeType=S"
    keys="$keys AttributeName=$sk,KeyType=RANGE"
  fi
  # shellcheck disable=SC2086
  aws dynamodb create-table --table-name "$name" --attribute-definitions $attrs --key-schema $keys \
    --billing-mode PAY_PER_REQUEST --endpoint-url "$ENDPOINT" >/dev/null
  echo "Tabla $name creada"
}

create_table "orders" "id"

```
