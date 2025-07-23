-- =================================================================
--         FINAL UNIFIED DATABASE SCHEMA (VERSION 2.0)
-- =================================================================
-- This script incorporates advanced real-world features including
-- role-based logic, soft deletes, status enums, and dedicated
-- payment tracking. It is designed to be re-runnable.
-- =================================================================


-- =================================================================
-- I. CUSTOM TYPES (Enums)
-- =================================================================
-- Foundational Enums
DO $$ BEGIN IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'app_role') THEN CREATE TYPE app_role AS ENUM ('admin', 'manager', 'user'); END IF; END $$;
DO $$ BEGIN IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'kyc_status') THEN CREATE TYPE kyc_status AS ENUM ('not_submitted', 'pending_review', 'approved', 'rejected'); END IF; END $$;

-- Accounting & Product Enums
DO $$ BEGIN IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'account_class') THEN CREATE TYPE account_class AS ENUM ('ASSET', 'LIABILITY', 'EQUITY', 'REVENUE', 'EXPENSE'); END IF; END $$;
DO $$ BEGIN IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'product_type') THEN CREATE TYPE product_type AS ENUM ('GOOD', 'SERVICE'); END IF; END $$;

-- Performance Target Enums
DO $$ BEGIN IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'target_period') THEN CREATE TYPE target_period AS ENUM ('MONTHLY', 'QUARTERLY', 'YEARLY', 'CUSTOM'); END IF; END $$;
DO $$ BEGIN IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'target_metric') THEN CREATE TYPE target_metric AS ENUM ('REVENUE', 'PROFIT', 'QUANTITY_SOLD'); END IF; END $$;
DO $$ BEGIN IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'target_creator') THEN CREATE TYPE target_creator AS ENUM ('ADMIN', 'MANAGER'); END IF; END $$;
DO $$ BEGIN IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'target_status') THEN CREATE TYPE target_status AS ENUM ('ACTIVE', 'ACHIEVED', 'MISSED'); END IF; END $$;

-- Operational Enums
DO $$ BEGIN IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'daily_log_type') THEN CREATE TYPE daily_log_type AS ENUM ('GENERAL_UPDATE', 'SITE_VISIT', 'CLIENT_MEETING', 'SUPPLIER_MEETING', 'INCIDENT_REPORT'); END IF; END $$;

-- NEW: Transactional Status & Payment Enums
DO $$ BEGIN IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'invoice_status') THEN CREATE TYPE invoice_status AS ENUM ('draft', 'sent', 'paid', 'partially_paid', 'void'); END IF; END $$;
DO $$ BEGIN IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'bill_status') THEN CREATE TYPE bill_status AS ENUM ('draft', 'submitted', 'paid', 'partially_paid', 'void'); END IF; END $$;
DO $$ BEGIN IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'reconciliation_status') THEN CREATE TYPE reconciliation_status AS ENUM ('in_progress', 'completed', 'cancelled'); END IF; END $$;
DO $$ BEGIN IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'payment_method') THEN CREATE TYPE payment_method AS ENUM ('cash', 'bank_transfer', 'credit_card', 'cheque', 'other'); END IF; END $$;


-- =================================================================
-- II. FOUNDATIONAL TABLES
-- =================================================================

CREATE TABLE IF NOT EXISTS public.companies (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ -- For soft deletes
);
COMMENT ON TABLE public.companies IS 'The central "tenant" table representing each business. Uses soft deletes.';

CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    full_name TEXT,
    avatar_url TEXT,
    role app_role NOT NULL DEFAULT 'user',
    company_id UUID REFERENCES public.companies(id) ON DELETE SET NULL,
    -- IMPROVED: This constraint enforces the specific business rule for role/company association.
    CONSTRAINT role_company_check CHECK (
        (role = 'manager' AND company_id IS NOT NULL) OR
        (role IN ('admin', 'user') AND company_id IS NULL)
    )
);
COMMENT ON TABLE public.profiles IS 'Stores user data. Admins are global (company_id is NULL). Users are unassigned (company_id is NULL). Managers MUST be assigned to a company.';

CREATE TABLE IF NOT EXISTS public.profile_kyc (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    profile_id UUID UNIQUE NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    status kyc_status NOT NULL DEFAULT 'not_submitted',
    legal_full_name TEXT,
    email TEXT, -- Maintained for KYC snapshot, primary email is in auth.users
    phone_number TEXT, -- Maintained for KYC snapshot
    pan_card_number TEXT,
    aadhar_card_number TEXT,
    address JSONB,
    rejection_reason TEXT
);
COMMENT ON TABLE public.profile_kyc IS 'Stores sensitive, private KYC data for a user.';
COMMENT ON COLUMN public.profile_kyc.pan_card_number IS 'SECURITY WARNING: Storing sensitive PII in plain text is a significant security risk. Consider using pgsodium for column-level encryption.';
COMMENT ON COLUMN public.profile_kyc.aadhar_card_number IS 'SECURITY WARNING: Storing sensitive PII in plain text is a significant security risk. Consider using pgsodium for column-level encryption.';


CREATE TABLE IF NOT EXISTS public.profile_references (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    kyc_id UUID NOT NULL REFERENCES public.profile_kyc(id) ON DELETE CASCADE,
    reference_type TEXT NOT NULL,
    full_name TEXT NOT NULL,
    relationship TEXT,
    phone_number TEXT NOT NULL,
    address JSONB
);
COMMENT ON TABLE public.profile_references IS 'Stores guardian or emergency contacts for a KYC profile.';

CREATE TABLE IF NOT EXISTS public.chart_of_accounts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id UUID NOT NULL REFERENCES public.companies(id) ON DELETE CASCADE,
    account_code TEXT,
    account_name TEXT NOT NULL,
    account_class account_class NOT NULL,
    account_type TEXT, -- NEW: For more specific classification (e.g., 'Bank Account', 'Accounts Receivable')
    parent_account_id UUID REFERENCES public.chart_of_accounts(id) ON DELETE SET NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    description TEXT,
    deleted_at TIMESTAMPTZ, -- For soft deletes
    CONSTRAINT account_name_unique_per_company UNIQUE (company_id, account_name),
    CONSTRAINT account_code_unique_per_company UNIQUE (company_id, account_code)
);
COMMENT ON TABLE public.chart_of_accounts IS 'Defines all financial accounts. A sub-type can be added for more detail.';


-- =================================================================
-- III. CORE BUSINESS ENTITY & CONFIGURATION TABLES
-- =================================================================

CREATE TABLE IF NOT EXISTS public.customers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id UUID NOT NULL REFERENCES public.companies(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    details JSONB,
    deleted_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS public.suppliers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id UUID NOT NULL REFERENCES public.companies(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    details JSONB,
    deleted_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS public.tax_rates (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id UUID NOT NULL REFERENCES public.companies(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    rate DECIMAL(5, 4) NOT NULL CHECK (rate >= 0),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    deleted_at TIMESTAMPTZ
);

-- NEW: Warehouses table for multi-location inventory
CREATE TABLE IF NOT EXISTS public.warehouses (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id UUID NOT NULL REFERENCES public.companies(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    location TEXT,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    deleted_at TIMESTAMPTZ
);
COMMENT ON TABLE public.warehouses IS 'Represents physical locations for storing inventory.';

CREATE TABLE IF NOT EXISTS public.products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id UUID NOT NULL REFERENCES public.companies(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    sku TEXT,
    type product_type NOT NULL DEFAULT 'GOOD',
    description TEXT,
    sale_price DECIMAL(12, 2),
    purchase_price DECIMAL(12, 2),
    cogs_account_id UUID REFERENCES public.chart_of_accounts(id) ON DELETE SET NULL,
    revenue_account_id UUID REFERENCES public.chart_of_accounts(id) ON DELETE SET NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    deleted_at TIMESTAMPTZ,
    CONSTRAINT product_sku_unique_per_company UNIQUE (company_id, sku)
);
COMMENT ON TABLE public.products IS 'Master list of all goods and services a company offers.';


-- =================================================================
-- IV. TRANSACTIONAL & OPERATIONAL TABLES
-- =================================================================

CREATE TABLE IF NOT EXISTS public.bank_reconciliations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    account_id UUID NOT NULL REFERENCES public.chart_of_accounts(id),
    statement_date DATE NOT NULL,
    ending_balance DECIMAL(12, 2) NOT NULL,
    status reconciliation_status NOT NULL DEFAULT 'in_progress', -- IMPROVED: Use ENUM
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.journal_entries (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id UUID NOT NULL REFERENCES public.companies(id) ON DELETE CASCADE,
    entry_date DATE NOT NULL,
    narration TEXT NOT NULL,
    source_document_id UUID,
    source_document_type TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.journal_lines (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    journal_entry_id UUID NOT NULL REFERENCES public.journal_entries(id) ON DELETE CASCADE,
    account_id UUID NOT NULL REFERENCES public.chart_of_accounts(id) ON DELETE RESTRICT,
    debit DECIMAL(12, 2) NOT NULL DEFAULT 0.00 CHECK (debit >= 0),
    credit DECIMAL(12, 2) NOT NULL DEFAULT 0.00 CHECK (credit >= 0),
    reconciliation_id UUID REFERENCES public.bank_reconciliations(id) ON DELETE SET NULL,
    CONSTRAINT debit_or_credit_must_exist CHECK (debit > 0 OR credit > 0),
    CONSTRAINT debit_and_credit_cannot_coexist CHECK (debit = 0 OR credit = 0)
);

CREATE TABLE IF NOT EXISTS public.sales_invoices (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id UUID NOT NULL REFERENCES public.companies(id) ON DELETE CASCADE,
    customer_id UUID NOT NULL REFERENCES public.customers(id) ON DELETE RESTRICT,
    invoice_number TEXT NOT NULL,
    invoice_date DATE NOT NULL,
    due_date DATE,
    subtotal DECIMAL(12, 2) NOT NULL,
    total_tax DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    total_amount DECIMAL(12, 2) NOT NULL,
    amount_paid DECIMAL(12, 2) NOT NULL DEFAULT 0.00, -- Denormalized for quick lookups
    status invoice_status NOT NULL DEFAULT 'draft', -- IMPROVED: Use ENUM
    CONSTRAINT invoice_number_unique_per_company UNIQUE (company_id, invoice_number)
);

CREATE TABLE IF NOT EXISTS public.sales_invoice_lines (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    invoice_id UUID NOT NULL REFERENCES public.sales_invoices(id) ON DELETE CASCADE,
    product_id UUID REFERENCES public.products(id) ON DELETE SET NULL,
    description TEXT NOT NULL,
    quantity DECIMAL(10, 2) NOT NULL,
    unit_price DECIMAL(12, 2) NOT NULL,
    tax_rate_id UUID REFERENCES public.tax_rates(id) ON DELETE SET NULL,
    line_total DECIMAL(12, 2) NOT NULL
);

-- NEW: Dedicated table for invoice payments
CREATE TABLE IF NOT EXISTS public.invoice_payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    invoice_id UUID NOT NULL REFERENCES public.sales_invoices(id) ON DELETE CASCADE,
    payment_date DATE NOT NULL,
    amount DECIMAL(12, 2) NOT NULL CHECK (amount > 0),
    method payment_method NOT NULL DEFAULT 'bank_transfer',
    reference_number TEXT,
    notes TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
COMMENT ON TABLE public.invoice_payments IS 'Tracks individual payments made against a sales invoice.';

CREATE TABLE IF NOT EXISTS public.purchase_bills (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id UUID NOT NULL REFERENCES public.companies(id) ON DELETE CASCADE,
    supplier_id UUID NOT NULL REFERENCES public.suppliers(id) ON DELETE RESTRICT,
    bill_number TEXT,
    bill_date DATE NOT NULL,
    due_date DATE,
    subtotal DECIMAL(12, 2) NOT NULL,
    total_tax DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    total_amount DECIMAL(12, 2) NOT NULL,
    amount_paid DECIMAL(12, 2) NOT NULL DEFAULT 0.00, -- Denormalized for quick lookups
    status bill_status NOT NULL DEFAULT 'draft' -- IMPROVED: Use ENUM
);

CREATE TABLE IF NOT EXISTS public.purchase_bill_lines (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    bill_id UUID NOT NULL REFERENCES public.purchase_bills(id) ON DELETE CASCADE,
    product_id UUID REFERENCES public.products(id) ON DELETE SET NULL,
    description TEXT NOT NULL,
    quantity DECIMAL(10, 2) NOT NULL,
    unit_price DECIMAL(12, 2) NOT NULL,
    tax_rate_id UUID REFERENCES public.tax_rates(id) ON DELETE SET NULL,
    line_total DECIMAL(12, 2) NOT NULL
);

-- NEW: Dedicated table for bill payments
CREATE TABLE IF NOT EXISTS public.bill_payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    bill_id UUID NOT NULL REFERENCES public.purchase_bills(id) ON DELETE CASCADE,
    payment_date DATE NOT NULL,
    amount DECIMAL(12, 2) NOT NULL CHECK (amount > 0),
    method payment_method NOT NULL DEFAULT 'bank_transfer',
    reference_number TEXT,
    notes TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
COMMENT ON TABLE public.bill_payments IS 'Tracks individual payments made against a purchase bill.';


CREATE TABLE IF NOT EXISTS public.inventory_movements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
    warehouse_id UUID NOT NULL REFERENCES public.warehouses(id) ON DELETE RESTRICT, -- IMPROVED: Track location
    movement_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    quantity_change DECIMAL(10, 2) NOT NULL,
    reason TEXT NOT NULL,
    source_document_id UUID,
    notes TEXT
);
COMMENT ON TABLE public.inventory_movements IS 'Audit trail of all inventory changes, now location-aware.';

CREATE TABLE IF NOT EXISTS public.performance_targets (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id UUID NOT NULL REFERENCES public.companies(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    period target_period NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    metric target_metric NOT NULL,
    target_value DECIMAL(15, 2) NOT NULL,
    product_id UUID REFERENCES public.products(id) ON DELETE SET NULL,
    created_by_role target_creator NOT NULL,
    status target_status NOT NULL DEFAULT 'ACTIVE',
    notes TEXT
);

CREATE TABLE IF NOT EXISTS public.fixed_assets (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id UUID NOT NULL REFERENCES public.companies(id) ON DELETE CASCADE,
    asset_name TEXT NOT NULL,
    purchase_date DATE NOT NULL,
    purchase_price DECIMAL(12, 2) NOT NULL,
    asset_account_id UUID NOT NULL REFERENCES public.chart_of_accounts(id),
    accumulated_depreciation_account_id UUID NOT NULL REFERENCES public.chart_of_accounts(id)
);

CREATE TABLE IF NOT EXISTS public.daily_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id UUID NOT NULL REFERENCES public.companies(id) ON DELETE CASCADE,
    created_by UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    log_date DATE NOT NULL DEFAULT CURRENT_DATE,
    log_type daily_log_type NOT NULL DEFAULT 'GENERAL_UPDATE',
    notes TEXT NOT NULL,
    latitude DECIMAL(9, 6),
    longitude DECIMAL(9, 6),
    address_snapshot TEXT
);

CREATE TABLE IF NOT EXISTS public.log_attachments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    log_id UUID NOT NULL REFERENCES public.daily_logs(id) ON DELETE CASCADE,
    storage_path TEXT NOT NULL,
    file_name TEXT,
    mime_type TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


-- =================================================================
-- V. INDEXES FOR PERFORMANCE
-- =================================================================
-- Existing Indexes
CREATE INDEX IF NOT EXISTS idx_profiles_company_id ON public.profiles(company_id);
CREATE INDEX IF NOT EXISTS idx_chart_of_accounts_company_id ON public.chart_of_accounts(company_id);
CREATE INDEX IF NOT EXISTS idx_products_company_id ON public.products(company_id);
CREATE INDEX IF NOT EXISTS idx_sales_invoices_company_id ON public.sales_invoices(company_id);
CREATE INDEX IF NOT EXISTS idx_journal_entries_company_id ON public.journal_entries(company_id);
CREATE INDEX IF NOT EXISTS idx_journal_lines_account_id ON public.journal_lines(account_id);

-- NEW: Indexes for Soft Deletes (for efficient filtering of active records)
CREATE INDEX IF NOT EXISTS idx_companies_deleted_at ON public.companies(deleted_at);
CREATE INDEX IF NOT EXISTS idx_products_deleted_at ON public.products(deleted_at);
CREATE INDEX IF NOT EXISTS idx_customers_deleted_at ON public.customers(deleted_at);
CREATE INDEX IF NOT EXISTS idx_suppliers_deleted_at ON public.suppliers(deleted_at);

-- NEW: Indexes for new foreign keys and frequent lookups
CREATE INDEX IF NOT EXISTS idx_invoice_payments_invoice_id ON public.invoice_payments(invoice_id);
CREATE INDEX IF NOT EXISTS idx_bill_payments_bill_id ON public.bill_payments(bill_id);
CREATE INDEX IF NOT EXISTS idx_inventory_movements_warehouse_id ON public.inventory_movements(warehouse_id);
CREATE INDEX IF NOT EXISTS idx_inventory_movements_product_id ON public.inventory_movements(product_id);


-- =================================================================
-- VI. AUTOMATIC PROFILE CREATION TRIGGER
-- =================================================================
-- This script safely drops and recreates the function and trigger.
-- It correctly creates a new user with the 'user' role, which will
-- have a NULL company_id as per the CHECK constraint.

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
DROP FUNCTION IF EXISTS public.handle_new_user();

CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name, role)
  VALUES (
    new.id,
    new.raw_user_meta_data->>'full_name',
    'user' -- New signups default to 'user' role, unassigned to a company.
  );
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();

COMMENT ON FUNCTION public.handle_new_user IS 'Creates a new user profile upon signup with the default "user" role. Runs as SECURITY DEFINER.';