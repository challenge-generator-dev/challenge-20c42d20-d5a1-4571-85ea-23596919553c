# Implementación de CRUD de órdenes en DynamoDB

Implementa operaciones CRUD (crear, leer, actualizar, eliminar) de órdenes sobre una tabla DynamoDB, expuestas por una API REST. La tabla DynamoDB almacenará información de órdenes de compra de un sistema de e-commerce. Cada orden debe tener un identificador único, fecha de creación, estado, y una lista de productos con sus cantidades. Asegúrate de manejar correctamente los casos de error y validaciones necesarias, como la existencia de una orden antes de actualizarla o eliminarla.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | CRUD de ordenes sobre DynamoDB |
| **Nivel** | advanced-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 8 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y entregará cada archivo con su ruta.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Node.js 18+, npm, VS Code o similar.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y entregará cada archivo con su ruta. Guárdalos en la carpeta donde quieras trabajar, respetando las rutas.
- Ejecuta `npm install && npm run build` (o `npm start`). Si no hay errores, estás listo.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no entrega todos los archivos al terminar el análisis, escríbele: "entrégame todos los archivos con su ruta".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Configuración inicial y creación de la tabla DynamoDB

**Objetivo:** Configurar el entorno de desarrollo y crear la tabla DynamoDB para almacenar órdenes.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Configura tu entorno de desarrollo con las herramientas necesarias para trabajar con Node.js y DynamoDB.
- Crea una tabla DynamoDB con las columnas necesarias para almacenar órdenes (identificador, fecha de creación, estado, lista de productos).

**Entregable:** Tabla DynamoDB creada y configurada con las columnas necesarias.

<details>
<summary>Pistas de conocimiento</summary>

- Usa Terraform para configurar la infraestructura como código.
- Revisa la documentación de DynamoDB para entender cómo crear y configurar tablas.

</details>

### Fase 2: Implementación de la API REST para operaciones CRUD

**Objetivo:** Implementar las operaciones CRUD (crear, leer, actualizar, eliminar) de órdenes en la API REST.

**Tiempo estimado:** 4 horas

**Instrucciones:**

- Implementa las rutas y controladores necesarios para las operaciones CRUD de órdenes en la API REST.
- Asegúrate de manejar correctamente los casos de error y validaciones necesarias, como la existencia de una orden antes de actualizarla o eliminarla.

**Entregable:** API REST implementada con operaciones CRUD de órdenes, incluyendo manejo de errores y validaciones.

<details>
<summary>Pistas de conocimiento</summary>

- Usa Terraform para configurar la infraestructura como código.
- Revisa la documentación de DynamoDB para entender cómo realizar operaciones CRUD en la tabla.

</details>

### Fase 3: Pruebas y optimización de la API REST

**Objetivo:** Realizar pruebas unitarias y de integración de la API REST y optimizar el rendimiento de las operaciones CRUD.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Escribe pruebas unitarias y de integración para validar el funcionamiento correcto de las operaciones CRUD de órdenes en la API REST.
- Identifica y optimiza los puntos de rendimiento crítico en las operaciones CRUD.

**Entregable:** API REST con pruebas unitarias y de integración, y rendimiento optimizado para las operaciones CRUD.

<details>
<summary>Pistas de conocimiento</summary>

- Usa Terraform para configurar la infraestructura como código.
- Revisa la documentación de DynamoDB para entender cómo optimizar el rendimiento de las operaciones CRUD.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es una operación CRUD en el contexto de una API REST que interactúa con DynamoDB?
- **paraQueSirve**: ¿Para qué sirve implementar operaciones CRUD en una API REST que interactúa con DynamoDB?
- **comoSeUsa**: ¿Cómo se usan las operaciones CRUD en una API REST que interactúa con DynamoDB?
- **erroresComunes**: ¿Cuáles son los errores comunes al implementar operaciones CRUD en una API REST que interactúa con DynamoDB?
- **queDecisionesImplica**: ¿Qué decisiones implica implementar operaciones CRUD en una API REST que interactúa con DynamoDB?

## Criterios de Evaluacion

- Configuración correcta del entorno de desarrollo y creación de la tabla DynamoDB.
- Implementación correcta de las operaciones CRUD en la API REST, incluyendo manejo de errores y validaciones.
- Realización de pruebas unitarias y de integración para validar el funcionamiento correcto de la API REST.
- Identificación y optimización de los puntos de rendimiento crítico en las operaciones CRUD.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT) si no tenes un agente en el IDE. Declara lo mismo que AGENTS.md; los archivos que te devuelva el chat los guardas en esta carpeta respetando las rutas.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

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

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
(cd app && npm install --no-audit --no-fund && npm run build) && (cd infra && terraform init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/dynamodb init -backend=false && terraform validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/dynamodb validate) && docker compose config -q
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
