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

<img width="318" height="192" alt="image" src="https://github.com/user-attachments/assets/fd508376-a738-4815-baec-a39a1ddce412" />



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
| POST   | `/auth/signup`   | Registro de usuario               | ✅ Sí         |
| POST   | `/auth/login`    | Inicio de sesión                  | ✅ Sí         |
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
Inicio de Sesión
Request
POST /auth/login
{
  "email": "usuario@correo.com",
  "password": "123456"
}
Response

{
  "access_token": "jwt_generado_aquí"
}
Perfil de Usuario
Request

GET /auth/profile
Authorization: Bearer <token_jwt>
Response

{
  "id": 1,
  "email": "usuario@correo.com",
  "createdAt": "2025-08-09T12:00:00.000Z"
}
Crear Tarea
Request

POST /tasks
Authorization: Bearer <token_jwt>
{
  "title": "Comprar pan",
  "description": "Ir a la panadería antes de las 8 am"
}
Response

{
  "id": 5,
  "title": "Comprar pan",
  "description": "Ir a la panadería antes de las 8 am",
  "status": "pending",
  "createdAt": "2025-08-09T12:10:00.000Z"
}
