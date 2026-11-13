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