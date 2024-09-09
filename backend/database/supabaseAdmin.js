import { createClient } from '@supabase/supabase-js';    
import dotenv from 'dotenv';
dotenv.config();

const supabaseAdmin = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_SERVICE_KEY, {autoRefreshToken: true});
export default supabaseAdmin;