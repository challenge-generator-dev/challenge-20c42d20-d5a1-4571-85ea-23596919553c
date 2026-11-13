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