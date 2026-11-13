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