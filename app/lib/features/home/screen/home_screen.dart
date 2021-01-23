import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_selecao/configs/ui/Cores.dart';
import 'package:teste_selecao/configs/ui/DimensoesTela.dart';
import 'package:teste_selecao/configs/ui/Fontes.dart';
import 'package:teste_selecao/configs/ui/Icones.dart';
import 'package:teste_selecao/configs/ui/Strings.dart';
import 'package:teste_selecao/features/home/models/empresas_model.dart';
import 'package:teste_selecao/features/home/screen/bloc/home_cubit.dart';
import 'package:teste_selecao/features/home/screen/widgets/item_empresa_factory.dart';
import 'package:teste_selecao/features/home/screen/widgets/top_container.dart';
import 'package:teste_selecao/injection_container.dart';
import 'package:teste_selecao/widgets/cached_image/cached_image.dart';
import 'package:teste_selecao/widgets/campo_form/campo_form.dart';
import 'package:teste_selecao/widgets/custom_loading/custom_loading.dart';
import 'package:teste_selecao/widgets/error_widgets/erro_api_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _alturaTopContainer = 200.h;
  HomeScreenCubit cubit;
  ItemEmpresaFactory itemEmpresaFactory = ItemEmpresaFactory();

  _alterarAlturaContainer(bool comFoco) {
    setState(() {
      _alturaTopContainer = comFoco ? 50.h : 200.h;
    });
  }

  @override
  void initState() {
    cubit = dependencia<HomeScreenCubit>();
    cubit.buscarEmpresas(termoBusca: '');
    super.initState();
  }

  _recarregar(BuildContext context) {
    BlocProvider.of<HomeScreenCubit>(context).buscarEmpresas(termoBusca: '');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<HomeScreenCubit, HomeState>(
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopContainer(alturaContainer: _alturaTopContainer),
                  if (state is LoadingState)
                    Container(
                      margin: EdgeInsets.only(top: 200.h),
                      child: CustomLoading(),
                    ),
                  if (state is DadosCarregadosState)
                    _buildContent(
                      state.empresasModel.enterprises?.length,
                      state?.empresasModel,
                    ),
                  if (state is ApiError)
                    ErroApiWidget(
                      aoApertarTentarNovamente: () => _recarregar(context),
                    )
                ],
              ),
              _buildSearchBar(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(
    int totaisEncontrados,
    EmpresasModel empresasModel,
  ) {
    return Expanded(
      child: SingleChildScrollView(
        child: itemEmpresaFactory.buildItens(empresasModel?.enterprises),
      ),
    );
  }

  Widget _buildSearchBar() {
    return AnimatedPositioned(
      top: _alturaTopContainer - 22.h,
      duration: Duration(milliseconds: 500),
      child: Container(
        width: 375.w,
        child: CampoForm(
          onFocus: (focus) => _alterarAlturaContainer(focus),
          hintText: Strings.pesquisePorEmpresas,
          fillColor: Cores.cinza[100],
          hintColor: Cores.cinza[200],
          prefixIcon: Container(
            padding: EdgeInsets.all(10.w),
            height: 20.h,
            width: 20.h,
            child: Image.asset(
              IconesAplicacao.iconeLupa,
              color: Cores.cinza[200],
            ),
          ),
        ),
      ),
    );
  }
}
