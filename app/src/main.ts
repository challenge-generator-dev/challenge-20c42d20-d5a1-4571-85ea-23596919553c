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