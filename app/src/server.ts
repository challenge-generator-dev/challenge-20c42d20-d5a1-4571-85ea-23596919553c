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