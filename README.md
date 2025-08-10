# 📌 Gestor de Tareas Personal – Backend

Este repositorio contiene la implementación **completa del backend** para la prueba técnica *Software Engineer Wagon*.  
La API está desarrollada en **NestJS** con **Prisma ORM** y **PostgreSQL**, e incluye autenticación con **JWT**.

---

## 🚀 Tecnologías Utilizadas

- **Lenguaje**: TypeScript  
- **Framework**: [NestJS](https://nestjs.com/)  
- **ORM**: [Prisma](https://www.prisma.io/)  
- **Base de Datos**: PostgreSQL  
- **Autenticación**: JWT (JSON Web Tokens)  
- **Gestor de Paquetes**: npm o yarn

---

## 📂 Estructura del Proyecto

/src
├── app.module.ts # Módulo raíz
├── main.ts # Punto de arranque
├── auth/ # Registro, login y perfil
├── tasks/ # CRUD de tareas
├── users/ # Módulo de usuario
├── prisma/ # Cliente y configuración de Prisma
└── common/ # Middlewares y utilidades
.env # Variables de entorno
prisma/schema.prisma # Definición de modelos de datos

markdown
Copiar
Editar

## 🔑 Funcionalidades Implementadas

- **Autenticación y Autorización** con JWT.  
- **Registro de usuario** (`/auth/signup`).  
- **Inicio de sesión** (`/auth/login`).  
- **Perfil de usuario autenticado** (`/auth/profile`).  
- **Gestión de tareas**:
  - Crear tarea (`POST /tasks`)
  - Listar tareas (`GET /tasks`)
  - Obtener tarea por ID (`GET /tasks/:id`)
  - Actualizar tarea (`PUT /tasks/:id`)
  - Eliminar tarea (`DELETE /tasks/:id`)
  - Filtrar por estado (pendiente / completada)
  - 
## 📡 Endpoints

| Método | Endpoint         | Descripción                       | Autenticación |
|--------|------------------|-----------------------------------|---------------|
| POST   | `/auth/signup`   | Registro de usuario               | ❌ No         |
| POST   | `/auth/login`    | Inicio de sesión                  | ❌ No         |
| GET    | `/auth/profile`  | Datos del usuario autenticado     | ✅ Sí         |
| GET    | `/tasks`         | Listar todas las tareas           | ✅ Sí         |
| GET    | `/tasks/:id`     | Obtener tarea por ID              | ✅ Sí         |
| POST   | `/tasks`         | Crear nueva tarea                 | ✅ Sí         |
| PUT    | `/tasks/:id`     | Actualizar tarea                  | ✅ Sí         |
| DELETE | `/tasks/:id`     | Eliminar tarea                    | ✅ Sí         |


## 📄 Ejemplos de Requests y Responses

### Registro de Usuario
**Request**
Response

{
  "id": 1,
  "email": "usuario@correo.com",
  "createdAt": "2025-08-09T12:00:00.000Z"
}
