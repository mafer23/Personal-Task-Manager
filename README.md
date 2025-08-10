<h1>📌 Gestor de Tareas Personal – Backend </h1>

Este repositorio contiene la implementación del backend.
La API está desarrollada en NestJS, utiliza Prisma ORM para el manejo de datos y PostgreSQL como base de datos relacional.

🚀 Tecnologías Utilizadas
<br>
Lenguaje: TypeScript

Framework: NestJS

ORM: Prisma

Base de Datos: PostgreSQL

Autenticación: JWT (JSON Web Tokens)

Contenerización: Docker

Gestor de Paquetes: npm o yarn

📂 Estructura del Proyecto

<br>
bash

<br>
Copiar

<br>
Editar

<br>
/src
 ├── app.module.ts         # Módulo raíz
 ├── main.ts               # Punto de arranque de la app
 ├── auth/                 # Módulo de autenticación
 ├── tasks/                # Módulo de tareas
 ├── prisma/               # Cliente y configuración de Prisma
 └── common/               # Utilidades y middlewares
.env                       # Variables de entorno
prisma/schema.prisma       # Definición de modelos de datos

<br>
🔑 Funcionalidades
Registro e inicio de sesión de usuarios.

Creación, consulta, actualización y eliminación de tareas.

Filtro de tareas por estado (pendiente, completada).

Protección de rutas mediante autenticación JWT.

📡 Endpoints Principales
Método	Endpoint	Descripción	Autenticación
POST	/auth/signup	Registro de usuario	❌ No
POST	/auth/login	Inicio de sesión	❌ No
GET	/tasks	Listar todas las tareas	✅ Sí
POST	/tasks	Crear una nueva tarea	✅ Sí
PUT	/tasks/:id	Actualizar una tarea	✅ Sí
DELETE	/tasks/:id	Eliminar una tarea	✅ Sí

⚙️ Instalación y Ejecución
1️⃣ Clonar repositorio
bash
Copiar
Editar
git clone 
cd gestor-tareas-backend
2️⃣ Configurar variables de entorno
Crear archivo .env en la raíz:

ini
Copiar
Editar
DATABASE_URL="postgresql://usuario:password@localhost:5432/nombre_db"
JWT_SECRET="clave_secreta"
PORT=3000
3️⃣ Instalar dependencias
bash
Copiar
Editar
npm install
4️⃣ Migrar base de datos con Prisma
bash
Copiar
Editar
npx prisma migrate dev --name init
5️⃣ Levantar servidor en desarrollo
bash
Copiar
Editar
npm run start:dev

🛠 Comandos útiles de Prisma
Abrir el cliente de Prisma Studio:

bash
Copiar
Editar
npx prisma studio
Generar cliente de Prisma:

bash
Copiar
Editar
npx prisma generate
📄 Licencia
Este proyecto es parte de una prueba técnica y no está destinado a uso comercial.

