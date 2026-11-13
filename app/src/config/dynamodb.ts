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