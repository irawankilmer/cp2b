<?php

namespace App\Http\Controllers;

use App\Models\Account;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Illuminate\View\View;

class AccountController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(): View
    {
        $accounts = Account::All();
        return view('account.index', compact('accounts'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(): View
    {
        return view('account.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'name' => ['required', 'string', 'max:255', 'unique:accounts'],
            'descriptions' => 'required',
        ]);

        Account::create([
            'name'    => $request->get('name'),
            'descriptions'    => $request->get('descriptions')
        ]);

        return redirect()->route('account')->with('success', 'Selamat, Data berhasil di tambahkan!');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id): View
    {
      $account = Account::find($id);
      return view('account.edit', compact('account'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
      $request->validate([
          'name'          => [
              'required', 'string', 'max:255',
              Rule::unique('accounts', 'name')->ignore($id),
          ],
          'descriptions'  => ['nullable', 'string']
      ]);

      $account = Account::findOrFail($id);
      $account->update([
          'name'          => $request->input('name'),
          'descriptions'  => $request->input('descriptions'),
      ]);

      return redirect()->route('account')->with('success', 'Data Berhasil diubah');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
      $account = Account::find($id);
      $account->delete();

      return redirect()->route('account')->with('success', 'Data Berhasil dihapus!');
    }
}
